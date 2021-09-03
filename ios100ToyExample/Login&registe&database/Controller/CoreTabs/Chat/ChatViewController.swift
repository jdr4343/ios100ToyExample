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
    var sender: SenderType //발신자
    var messageId: String //이메일
    var sentDate: Date //날짜
    var kind: MessageKind //메시지 종류
}
//발송자
struct Sender: SenderType {
    var photoURL: String //프로필 사진
    var senderId: String //이메일
    var displayName: String //유저이름
}

//채팅 화면 입니다.
class ChatViewController: MessagesViewController {
    
    //채팅을 하고 있는 상대방을 나타냅니다.아래의 이니셜라이저로 초기화 하고 conversation에서 result의 email을 전달 받습니다!
    public let otherUserEmail: String
    
    //새로운 대화인지 아니면 대화중인 상대인지 알수 있기 위해 불리언값을 추가해줍니다.
    public var isNewConversation = false
    
    //메시지 배열을 만듭니다.
    private var messages = [Message]()
    
    //발송자
    private var selfSender: Sender?{
        guard let email = UserDefaults.standard.value(forKey: "email") else {
            return nil
        }
        Sender(photoURL: "",
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
              let selfSender = self.selfSender else {
            return
        }
        //메시지를 보냅니다. /새로운 대화 인지 기존 대화인지 식별합니다.
        if isNewConversation {
            //새로운 대화를 데이터베이스에 추가합니다.
            let message = Message(sender: selfSender,
                                  messageId: <#T##String#>,
                                  sentDate: Date(),
                                  kind: .text(text))
            DatabaseManager.shared.createNewConversation(with: otherUserEmail, firstMessage: <#T##Message#>, completion: <#T##(Bool) -> Void#>)
        } else {
            //기존 대화를 데이터베이스에서 가져옵니다.
        }
    }
    //messageId 생성 무작위 문자열?
    private func createMessageId() -> String {
        // 날짜, 받은사람 이메일, 보낸사람 이메일
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

