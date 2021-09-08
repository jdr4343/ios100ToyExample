//
//  ChatViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/02.
//

import UIKit
import MessageKit
import InputBarAccessoryView
import SDWebImage
import AVFoundation
import AVKit
import CoreLocation

//메시지
struct Message: MessageType {
    public var sender: SenderType //보낸사람
    public var messageId: String //이메일
    public var sentDate: Date //날짜
    public var kind: MessageKind //메시지 종류
}
//메시지 종류 확장 / 문자열 속성으로 바꿔줍니다.
extension MessageKind {
    var messageKindString: String {
        switch self {
        case .text(_):
            return "text"
        case .attributedText(_):
            return "attributedText"
        case .photo(_):
            return "photo"
        case .video(_):
            return "video"
        case .location(_):
            return "location"
        case .emoji(_):
            return "emoji"
        case .audio(_):
            return "audio"
        case .contact(_):
            return "contact"
        case .linkPreview(_):
            return "linkPreview"
        case .custom(_):
            return "custom"
        }
    }
}

//보낸사람
struct Sender: SenderType {
    public var photoURL: String //프로필 사진
    public var senderId: String //이메일
    public var displayName: String //유저이름
}

//미디어 / 사진 비디오 등등
struct Media: MediaItem {
    var url: URL?
    var image: UIImage?
    var placeholderImage: UIImage
    var size: CGSize

}

//위치
struct Location: LocationItem {
    var location: CLLocation
    var size: CGSize
}

//오디오 // 구현대기
struct Audio: AudioItem {
    var url: URL
    var duration: Float
    var size: CGSize
}


//채팅 화면 입니다.
class ChatViewController: MessagesViewController {
    
    //날짜 포멧터를 만듭니다./ public static형식으로 만든다면 클래스의 인스턴스 없이 호출 가능하며 제한 없이 어디에서든 사용가능 합니다.
    public static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.locale = .current
        return formatter
    }()
    
    //채팅을 하고 있는 상대방을 나타냅니다.아래의 이니셜라이저로 초기화 하고 conversation에서 result의 email을 전달 받습니다!
    public let otherUserEmail: String
    //식별자를 만듭니다.
    private let conversationId: String?
    
    
    
    //새로운 대화인지 아니면 대화중인 상대인지 알수 있기 위해 불리언값을 추가해줍니다.
    public var isNewConversation = false
    
    //메시지 배열을 만듭니다.
    private var messages = [Message]()
    
    //발송자
    private var selfSender: Sender?{
        guard let email = UserDefaults.standard.value(forKey: "email") as? String else {
            return nil
        }
        //사용자가 보낸 메시지를 오른쪽에 띄웁니다.
        let safeEmail = DatabaseManager.safeEmail(emailAddress: email)
       return Sender(photoURL: "",
               senderId: safeEmail,
               displayName: "")
    }
    
 //생성자를 업데이트 하여 이메일과 ID를 가져옵니다
    init(with email: String, id: String?) {
        self.conversationId = id
        self.otherUserEmail = email
        super.init(nibName: nil, bundle: nil)
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        self.tabBarController?.tabBar.isHidden = true
        setupInputButton()
        navigationController?.navigationBar.tintColor = .label
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messagesCollectionView.messageCellDelegate = self
        messageInputBar.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        messageInputBar.inputTextView.becomeFirstResponder()
        if let conversationId = conversationId {
            //메시지가 스크롤바에 가리지 않도록 shouldScrollToBottom 함수를 만들어 추가
            listenForMessages(id: conversationId, shouldScrollToBottom: true)
        }
    }
    
    
    //MARK: - setUpInputBar
    //사진을 첨부하거나 비디오를 첨부하여 채팅을 보내기 위해 키보드 바 버튼을 만듭니다.
    private func setupInputButton() {
        let button = InputBarButtonItem()
        button.setSize(CGSize(width: 35, height: 35), animated: false)
        button.setImage(UIImage(systemName: "paperclip"), for: .normal)
        button.tintColor = .label
        //함수 내부에서 액션을 전달 하겠습니다.
        button.onTouchUpInside { [weak self] _ in
            self?.presentInputActionSheet()
        }
        //왼쪽으로 설정
        messageInputBar.setLeftStackViewWidthConstant(to: 36, animated: false)
        messageInputBar.setStackViewItems([button], forStack: .left, animated: false)
    }
    // 키보드 버튼 액션
    private func presentInputActionSheet() {
        let actionSheet = UIAlertController(title: "미디어를 첨부합니다.",
                                            message: "어떤걸 추가 하시겠습니까?",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "사진", style: .default, handler: { [weak self] _ in
            self?.presentPhotoInputActionSheet()
        }))
        actionSheet.addAction(UIAlertAction(title: "동영상", style: .default, handler: { [weak self] _ in
            self?.presentVideoInputActionSheet()
        }))
        actionSheet.addAction(UIAlertAction(title: "오디오", style: .default, handler: {  _ in
            
        }))
        actionSheet.addAction(UIAlertAction(title: "위치 정보", style: .default, handler: {  _ in
            
        }))
        actionSheet.addAction(UIAlertAction(title: "닫기", style: .default, handler: nil))
        present(actionSheet, animated: true)
    }
    
    // 사진 액션시트 버튼 액션
    private func presentPhotoInputActionSheet() {
        let actionSheet = UIAlertController(title: "사진 첨부",
                                            message: "사진을 첨부 하시겠습니까?",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "카메라", style: .default, handler: { [weak self] _ in
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.delegate = self
            picker.allowsEditing = true
            self?.present(picker, animated: true)
            
        }))
        actionSheet.addAction(UIAlertAction(title: "앨범", style: .default, handler: { [weak self] _ in
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            picker.allowsEditing = true
            self?.present(picker, animated: true)
        }))
        actionSheet.addAction(UIAlertAction(title: "닫기", style: .default, handler: nil))
        present(actionSheet, animated: true)
    }
    
    //비디오 액션시트 버튼 액션
    private func presentVideoInputActionSheet() {
        let actionSheet = UIAlertController(title: "동영상 첨부",
                                            message: "동영상를 첨부 하시겠습니까?",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "동영상", style: .default, handler: { [weak self] _ in
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.delegate = self
            //비디오만 선택할 수 있도록 제약 추가
            picker.mediaTypes = ["public.movie"]
            picker.videoQuality = .typeMedium
            picker.allowsEditing = true
            self?.present(picker, animated: true)
            
        }))
        actionSheet.addAction(UIAlertAction(title: "앨범", style: .default, handler: { [weak self] _ in
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            //비디오만 선택할 수 있도록 제약 추가
            picker.mediaTypes = ["public.movie"]
            picker.videoQuality = .typeMedium
            picker.allowsEditing = true
            self?.present(picker, animated: true)
        }))
        actionSheet.addAction(UIAlertAction(title: "닫기", style: .default, handler: nil))
        present(actionSheet, animated: true)
    }
    
    //위치 정보 액션시트 버튼 액션
    private func presentLocationInputActionSheet() {
        let vc = LocationPickerViewController()
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.completion = { [weak self] selectedCoordinates in
            //경도 / 위도
            let logitude: Double = selectedCoordinates.longitude
            let latitude: Double = selectedCoordinates.latitude
            print("경도 \(logitude) | 위도 \(latitude)")
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
  
    
    //대화 ID가 있는 모든 메시지를 가져오기라는 함수를 스터브 처리하여 해당 대화 ID를 전달합니다.
    private func listenForMessages(id: String, shouldScrollToBottom: Bool) {
        DatabaseManager.shared.getAllMessagesForConversation(with: id, completion: { [weak self] result in
            switch result {
            case .success(let messages):
                guard !messages.isEmpty else {
                    print("메시지가 비었습니다.")
                    return
                }
                self?.messages = messages
                DispatchQueue.main.async {
                //데이터를 다시 로드하고 오프셋을 유지하기 위해 reloadDataAndKeepOffset 추가
                self?.messagesCollectionView.reloadDataAndKeepOffset()
                    //스크롤
                    if shouldScrollToBottom {
                        self?.messagesCollectionView.scrollToLastItem()
                    }
                    
                }
            case .failure(let error):
                print("메시지를 얻지 못했습니다.\(error)")
            }
        })
    }
    

}
//MARK: - 이미지 피커 / 사진 / 동영상
extension ChatViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //이미지 선택기 취소
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    //이미지 선택기 이미지 선택 완료 / 사용자가 선택한 이미지를 가져옵니다.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let messageId = createMessageId(),
              let conversationId = conversationId ,
              let name = self.title,
              let selfSender = selfSender else {
            return
        }
        
        if let image = info[.editedImage] as? UIImage, let imageData = image.pngData() {
            //사진 업로드
            
            let fileName = "photo_message_" + messageId.replacingOccurrences(of: " ", with: "-") + ".png"
            
            StorageManager.shared.uploadMessagePhoto(with: imageData, fileName: fileName, completion: { [weak self] result in
                guard let strongSelf = self else {
                    return
                }
                
                switch result {
                case .success(let urlString):
                    //메시지를 보낼 준비를 합니다.
                    print("메시지 사진을 업로드 합니다 - \(urlString)")
                    guard let url = URL(string: urlString),
                          let placeholder = UIImage(systemName: "plus") else {
                        return
                    }
                    
                    let media = Media(url: url, image: nil, placeholderImage: placeholder, size: .zero)
                    
                    let message = Message(sender: selfSender,
                                          messageId: messageId,
                                          sentDate: Date(),
                                           kind: .photo(media))
                    
                    DatabaseManager.shared.sendMessage(to: conversationId, otherUserEmail: strongSelf.otherUserEmail, name: name, newMessage: message, completion: { success in
                        
                        if success {
                            print("사진 메시지가 성공적으로 전송 되었습니다.")
                        } else  {
                            print("사진 메시지 전송에 실패 했습니다.")
                        }
                        
                    })
                    
                case .failure(let error):
                    print("메시지 사진을 업로드 하는 것에 실패 했습니다. - \(error)")
                }
            })
            
        } //비디오 업로드
        else if let videoUrl = info[.mediaURL] as? URL {
            let fileName = "video_message_" + messageId.replacingOccurrences(of: " ", with: "-") + ".mov"
            
            StorageManager.shared.uploadMessageVideo(with: videoUrl, fileName: fileName, completion: { [weak self] result in
                guard let strongSelf = self else {
                    return
                }
                
                switch result {
                case .success(let urlString):
                    //메시지를 보낼 준비를 합니다.
                    print("메시지 동영상을 업로드 합니다 - \(urlString)")
                    guard let url = URL(string: urlString),
                          let placeholder = UIImage(systemName: "plus") else {
                        return
                    }
                    
                    let media = Media(url: url, image: nil, placeholderImage: placeholder, size: .zero)
                    
                    let message = Message(sender: selfSender,
                                          messageId: messageId,
                                          sentDate: Date(),
                                           kind: .video(media))
                    
                    DatabaseManager.shared.sendMessage(to: conversationId, otherUserEmail: strongSelf.otherUserEmail, name: name, newMessage: message, completion: { success in
                        
                        if success {
                            print("동영상 메시지가 성공적으로 전송 되었습니다.")
                        } else  {
                            print("동영상 메시지 전송에 실패 했습니다.")
                        }
                        
                    })
                    
                case .failure(let error):
                    print("메시지 동영상을 업로드 하는 것에 실패 했습니다. - \(error)")
                }
            })
            
            
            
        }
    }
}



//MARK: - MessageInputBar

extension ChatViewController: InputBarAccessoryViewDelegate {
    //보내기 버튼을 눌렀을때 텍스트 결과 값을 가져오 겠습니다
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        guard !text.replacingOccurrences(of: " ", with: "").isEmpty,
              let selfSender = self.selfSender,
              let messageId = createMessageId() else {
            return
        }
        
        //새로운 대화를 데이터베이스에 추가합니다.
        let message = Message(sender: selfSender,
                              messageId: messageId,
                              sentDate: Date(),
                              kind: .text(text))
        
        //메시지를 보냅니다. /새로운 대화 인지 기존 대화인지 식별합니다.
        if isNewConversation {
         
            DatabaseManager.shared.createNewConversation(with: otherUserEmail, name: self.title ?? "User", firstMessage: message, completion: { [weak self] success in
                if success {
                    print("메시지가 정상적으로 작동 했습니다.")
                    self?.isNewConversation = false
                } else {
                    print("메시지를 보내는것에 실패 했습니다")
                }
            })
        } else {
            guard let conversationId = conversationId,
                  let name = self.title else {
                return
            }
            //기존 대화를 데이터베이스에서 가져오고 메시지를 보내겠습니다.
            DatabaseManager.shared.sendMessage(to: conversationId, otherUserEmail: otherUserEmail,name: name, newMessage: message, completion: { success in
                if success {
                    print("메시지를 보냈습니다.")
                } else {
                    print("메시지를 보내는데 실패했습니다.")
                }
            })
        }
    }
    //messageId(식별자) 생성 무작위 문자열
    private func createMessageId() -> String? {
        //받은사람, 날짜, 이메일, 보낸사람 이메일 , 랜덤 숫자
        guard let currentUserEmail = UserDefaults.standard.value(forKey: "email") as? String else {
            return nil
        }
        //데이터베이스에서 사용할수 있도록 안전한 이메일로 바꿔 줍니다.
        let safeCurrentEmail = DatabaseManager.safeEmail(emailAddress: currentUserEmail)
        
        let dateString = Self.dateFormatter.string(from: Date())
        let newIdentifier = "\(otherUserEmail)_\(safeCurrentEmail)_\(dateString)"
        print("create message id: \(newIdentifier)") // create message id: IU-naver-com_jdr4343@naver.com_Sep 3, 2021 at 4:49 PM
        return newIdentifier
    }
}


//MARK: - 메세지

extension ChatViewController: MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {
    //현재 발신자를 확인 / 프레임워크가 채팅을 보낸 것처럼 오른쪽에 표시하거나 받은 것처럼 왼쪽에 채팅을 표시 하도록 결정합니다.
    func currentSender() -> SenderType {
        if let sender = selfSender {
            return sender
        }
        fatalError("발송인이 nil 이므로 이메일을 캐싱해야 합니다.")
        
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    //미디어 메시지 이미지 보기를 구성합니다. /사진 Url을 이미지로 보이도록 변환합니다.
    func configureMediaMessageImageView(_ imageView: UIImageView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        guard let message = message as? Message else {
            return
        }
        switch message.kind {
        case .photo(let media):
            guard let imageUrl = media.url else {
                return
            }
            imageView.sd_setImage(with: imageUrl, completed: nil)
        default:
            break
        }
    }
   
   
}

extension ChatViewController: MessageCellDelegate {
    //사용자가 사진 채팅 이미지를 클릭하면 사진혹은 비디오를 크게 보일수 있도록 뷰를 연결해주는 액션을 추가 하겠습니다.
    func didTapImage(in cell: MessageCollectionViewCell) {
        guard let indexPath = messagesCollectionView.indexPath(for: cell) else {
            return
        }
        
      let message = messages[indexPath.section]
        
      switch message.kind {
      
      case .photo(let media):
          guard let imageUrl = media.url else {
              return
          }
          let vc = PhotoViewerViewController(with: imageUrl)
          self.navigationController?.pushViewController(vc, animated: true)
        
      case .video(let media):
          guard let videoUrl = media.url else {
              return
          }
          //내장된 프레임 워크를 사용 하겠습니다.
          let vc = AVPlayerViewController()
            vc.player = AVPlayer(url: videoUrl)
            present(vc, animated: true)
        
      default:
          break
      }
    }
}


