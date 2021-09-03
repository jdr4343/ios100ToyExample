//
//  ChatViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/02.
//

import UIKit
import MessageKit
import InputBarAccessoryView

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
    
    //새로운 대화인지 아니면 대화중인 상대인지 알수 있기 위해 불리언값을 추가해줍니다.
    public var isNewConversation = false
    
    //메시지 배열을 만듭니다.
    private var messages = [Message]()
    
    //발송자
    private var selfSender: Sender?{
        guard let email = UserDefaults.standard.value(forKey: "email") as? String else {
            return nil
        }
       return Sender(photoURL: "",
               senderId: email,
               displayName: "Test Sender")
    }
    
    init(with email: String) {
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
        addMessagesData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        messageInputBar.inputTextView.becomeFirstResponder()
    }
    
    //메시지
    private func addMessagesData() {
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
        
     
    
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
        //메시지를 보냅니다. /새로운 대화 인지 기존 대화인지 식별합니다.
        if isNewConversation {
            //새로운 대화를 데이터베이스에 추가합니다.
            let message = Message(sender: selfSender,
                                  messageId: messageId,
                                  sentDate: Date(),
                                  kind: .text(text))
            DatabaseManager.shared.createNewConversation(with: otherUserEmail, firstMessage: message, completion: { success in
                if success {
                    print("메시지가 정상적으로 작동 했습니다.")
                } else {
                    print("메시지를 보내는것에 실패 했습니다")
                }
            })
        } else {
            //기존 대화를 데이터베이스에서 가져옵니다.
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


//MARK: - Message

extension ChatViewController: MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {
    //현재 발신자를 확인 / 프레임워크가 채팅을 보낸 것처럼 오른쪽에 표시하거나 받은 것처럼 왼쪽에 채팅을 표시 하도록 결정합니다.
    func currentSender() -> SenderType {
        if let sender = selfSender {
            return sender
        }
        fatalError("발송인이 nil 이므로 이메일을 캐싱해야 합니다.")
        return Sender(photoURL: "", senderId: "12", displayName: "")
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
}

