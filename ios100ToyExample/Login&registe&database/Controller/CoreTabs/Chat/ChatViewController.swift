//
//  ChatViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/02.
//

import UIKit
import MessageKit

//메시지
struct Message: MessageType {
    var sender: SenderType //발신자
    var messageId: String //이메일
    var sentDate: Date //날짜
    var kind: MessageKind //메시지 종류
}
//발신자
struct Sender: SenderType {
    var photoURL: String //프로필 사진
    var senderId: String //이메일
    var displayName: String //유저이름
}

//채팅 화면 입니다.
class ChatViewController: MessagesViewController {

    //채팅을 하고 있는 상대방을 나타냅니다.아래의 이니셜라이저로 초기화 하고 conversation에서 result의 email을 받아옵니다!
    public let otherUserEmail: String
    
    //새로운 대화인지 아니면 대화중인 상대인지 알수 있기 위해 불리언값을 추가해줍니다.
    public var isNewConversation = false
    
    //메시지 배열을 만듭니다.
    private var messages = [Message]()
    
    //테스트 발신자 // 삭제 대기
    private let mockSender = Sender(photoURL: "",
                                    senderId: "1",
                                    displayName: "Test Sender")
    
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
    //메시지
    private func addMessagesData() {
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        //테스트 메시지 //삭제 대기
        messages.append(Message(sender: mockSender,
                                messageId: "1",
                                sentDate: Date(),
                                kind: .text("테스트 메시지입니다.")))
        messages.append(Message(sender: mockSender,
                                messageId: "1",
                                sentDate: Date(),
                                kind: .text("테스트 메시지입니다. 오류가 생기지 않도록 기능 구현을 한후 삭제 해주세요!에베에베에베")))
    
    }

}

extension ChatViewController: MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {
    //현재 발신자를 확인 / 프레임워크가 채팅을 보낸 것처럼 오른쪽에 표시하거나 받은 것처럼 왼쪽에 채팅을 표시 하도록 결정합니다.
    func currentSender() -> SenderType {
        return mockSender
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    
}
