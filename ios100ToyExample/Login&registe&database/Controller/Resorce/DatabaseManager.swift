//
//  DatabaseManager.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/25.
//

import FirebaseDatabase

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    //데이터 베이스를 사용하기 위해 데이터베이스를 참조 하겠습니다.
    private let database = Database.database().reference()
    
    //재사용 가능한 속성으로 만들겠습니다. 
    static func safeEmail(emailAddress: String) -> String {
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
    
    //MARK: - public
    ///이메일과 유저이름을 사용할수 있는지 확인합니다.
    ///-parameter
    ///    -email: 이메일을 나타내는 문자열입니다.
    ///    -username: 유저이름을 나타내는 문자열입니다
    
    public func canCreateNewUser(with email: String, username: String, completion: (Bool) -> Void) {
        completion(true)
    }
    
   
}

//MARK: - 계정 관리

extension DatabaseManager {
    
    ///신규 회원가입 유저의 데이터를 데이터베이스에 추가합니다.
    ///-parameter
    ///    -email: 이메일을 나타내는 문자열입니다.
    ///    -username: 유저이름을 나타내는 문자열입니다
    ///    -completion: 데이터베이스 입력이 성공한 경우 결과에 대한 비동기 콜백입니다.
    
    public func userExists(with email: String, completion: @escaping ((Bool) -> Void)) {
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        
        database.child(safeEmail).observeSingleEvent(of: .value, with: { snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            completion(true)
        })
    }
    
    //새로운 사용자 개체가 생성되면 user 컬렉션에 추가합니다
    public func insertNewUser(with user: UserModel, completion: @escaping (Bool) -> Void) {
        //노드 삽입 / 키가 이메일이될 자식함수를 생성합니다. / 사용자가 다른 플랫폼을 통해서 로그인 할경우 사용자가 프로필 사진이 있는지 확인합니다. 삭제?
        database.child(user.safeEmail).setValue(["name": user.username], withCompletionBlock: { error, _ in
            guard error == nil else {
                print("Database - 58 데이터 베이스를 읽지 못했습니다.")
                completion(false)
                return
            }
            //이벤트를 관찰합니다.
            self.database.child("users").observeSingleEvent(of: .value, with: { snapshot in
                if var usersCollection = snapshot.value as? [[String:String]] {
                    //이중 dictionary 컬렉션 형식으로 두개의 node를 추가합니다. 키도 문자열 값도 문자열입니다.노드 창이 두개인 이유는 대화하는 발신자와 수신자를 구별하기 위해서 입니다.
                    let newElement = [
                        "name": user.username,
                        "email": user.safeEmail
                    ]
                    usersCollection.append(newElement)
                    //사용자가 참조 할수 있도록 firebase에 추가합니다.
                    self.database.child("users").setValue(usersCollection, withCompletionBlock: { error, _ in
                        guard error == nil else {
                            completion(false)
                            return
                        }
                        completion(true)
                    })
                } else {
                    // dictionary 배열을 만듭니다.
                    let newCollection: [[String: String]] = [
                        [
                            "name": user.username,
                            "email": user.safeEmail
                        ]
                    ]
                    //사용자가 참조 할수 있도록 firebase에 추가합니다.
                    self.database.child("users").setValue(newCollection, withCompletionBlock: { error, _ in
                        guard error == nil else {
                            completion(false)
                            return
                        }
                        completion(true)
                    })
                }
            })
        })
    }
    
    //MARK: - 대화 / 채팅 / 메시지
    
    //검색 기능 구현을 위해 함수를 추가합니다.
    public func getAllUsers(complation: @escaping (Result<[[String:String]], Error>) -> Void) {
        database.child("users").observeSingleEvent(of: .value, with: { snapshot in
            guard let value = snapshot.value as? [[String:String]] else {
                complation(.failure(DatabaseError.failedToFetch))
                return
            }
            //값을 전달합니다.
            complation(.success(value))
        })
    }
    
    //오류를 정의 하겠습니다.
    public enum DatabaseError: Error {
        case failedToFetch
    }
    
    
}
//새 대화 삽입 / 현재 사용자에 대한 모든 대화 목록을 반환 / 주어진 대화에 대한 모든 메시지를 반환

extension DatabaseManager {
    /* 새로운 대화 노드를 데이터베이스에 추가합니다.
     //메시지 노드 /받은사람
     "conversationID" {
         "messages": [
              {
                 "id": String, // 우리가 만들었던 messageId가 될것입니다. 받은사람_보낸사람_날짜 이런형식으로 저장될 것 입니다. 이형식을 토대로 식별 할것입니다
                 "type": text, photo, video, 메시지의 타입이 됩니다.
                 "content": String, 대화 내용이 됩니다.
                 "date": Date(), 보낸 시각이 될 것 입니다.
                 "sender_email": String, 보낸사람이 될 것 입니다.
                 "is_read": true/false 메시지를 확인 했는지 아니면 안보고 있는지를 나타 냅니다.
              }
            ]
       }
     //대화 노드 / 보낸 사람
     conversations => [
         [
               "conversation_id":
               "other_user-email":
               "name":
               "latest_message": => {
               "date": Date()
               "latest_message": "message"
               "is_read": true/false
            }
         ],
     ]
     
     
     */
    
    
    //상대방 이메일과 처음 보낸 메시지를 기반으로 새 대화를 생성 합니다.
    public func createNewConversation(with otherUserEmail: String, name: String, firstMessage: Message, completion: @escaping (Bool) -> Void) {
        guard let currentEmail = UserDefaults.standard.value(forKey: "email") as? String else {
            return
        }
        let safeEmail = DatabaseManager.safeEmail(emailAddress: currentEmail)
        let ref = database.child("\(safeEmail)")
        ref.observeSingleEvent(of: .value, with: { snapshot in
            guard var userNode = snapshot.value as? [String: Any] else {
                completion(false)
                print("사용자를 찾지 못했습니다.")
                return
            }
            //ID 식별자를 지정해줍니다.
            let conversationID = "conversation_\(firstMessage.messageId)"
            
            //날짜를 문자열 형식으로 바꿉니다
            let messageDate = firstMessage.sentDate
            let dateString = ChatViewController.dateFormatter.string(from: messageDate)
            
            //메시지의 내용을 텍스트 타입으로 추가해 줍니다.
            var message = ""
            switch firstMessage.kind {
            case .text(let messageText):
                message = messageText
            case .attributedText(_):
                break
            case .photo(_):
                break
            case .video(_):
                break
            case .location(_):
                break
            case .emoji(_):
                break
            case .audio(_):
                break
            case .contact(_):
                break
            case .linkPreview(_):
                break
            case .custom(_):
                break
            }
            let newConversationData: [String: Any] =
                [
                    "id": conversationID,
                "other_user_email": otherUserEmail,
                    "name": name,
                "latest_message":
                    [
                    "date": dateString,
                    "message": message,
                    "is_read": false
                    ]
                ]
            
            if var conversations = userNode["conversations"] as? [[String: Any]] {
                //현재 사용자에 대한 대화 배열을 추가해야합니다.
                conversations.append(newConversationData)
                userNode["conversations"] = conversations
                
                //사용자 노드의 값을 설정하고 싶다고 전달 합니다.
                ref.setValue(userNode, withCompletionBlock: { [weak self] error, _ in
                    guard error == nil else {
                        completion(false)
                        return
                    }
                    self?.finishCreatingConversation(name: name,
                                                     conversationID: conversationID,
                                                     firstMessage: firstMessage,
                                                     completion: completion)
                })
            } else {
                //위에서 만든 배열을 추가해 노드를 만듭니다.
                userNode["conversations"] = [
                    newConversationData
                ]
                
                ref.setValue(userNode, withCompletionBlock: { [weak self] error, _ in
                    guard error == nil else {
                        completion(false)
                        return
                    }
                    self?.finishCreatingConversation(name: name,
                                                     conversationID: conversationID,
                                                     firstMessage: firstMessage,
                                                     completion: completion)
                })
            }
        })
    }
    
    private func finishCreatingConversation(name: String, conversationID: String, firstMessage: Message, completion: @escaping (Bool) -> Void) {
//
        //           "id": String,
        //           "type": text, photo, video,
        //           "content": String,
        //           "date": Date(),
        //           "sender_email": String
        //           "isRead": true/false
        //메시지 내용
        var message = ""
        switch firstMessage.kind {
        case .text(let messageText):
            message = messageText
        case .attributedText(_):
            break
        case .photo(_):
            break
        case .video(_):
            break
        case .location(_):
            break
        case .emoji(_):
            break
        case .audio(_):
            break
        case .contact(_):
            break
        case .linkPreview(_):
            break
        case .custom(_):
            break
        }
        //날짜
        let messageDate = firstMessage.sentDate
        let dateString = ChatViewController.dateFormatter.string(from: messageDate)
        
        //보낸사람 지정 / email 형식을 안전한 이메일로 지정
        guard let myEmail = UserDefaults.standard.value(forKey: "email") as? String else {
            completion(false)
            return
        }
        let currentUserEmail = DatabaseManager.safeEmail(emailAddress: myEmail)
        
        let CollectionMessage: [String: Any] = [
            "id": firstMessage.messageId,
            "type": firstMessage.kind.messageKindString,
            "content": message,
            "date": dateString,
            "sender_email": currentUserEmail,
            "is_read": false,
            "name": name
        ]
        
        let value: [String: Any] = [
            "messages": [
                CollectionMessage
            ]
        ]
        print("식별자 확인: \(conversationID)")
        database.child("\(conversationID)").setValue(value, withCompletionBlock: { error, _ in
            guard error == nil else {
                completion(false)
                return
            }
            completion(true)
        })
    }

    //전달된 이메일 사용자의 모든 대화목록을 가져와서 반환합니다.
    public func getAllConversations(for email: String, completion: @escaping (Result<[Conversation],Error>) -> Void) {
        database.child("\(email)/conversations").observe(.value, with: { snapshot in
            guard let value = snapshot.value as? [[String: Any]] else {
                print("실패")
                completion(.failure(DatabaseError.failedToFetch))
                return
            }
            let conversations: [Conversation] = value.compactMap({ dictionary in
                guard let conversationId = dictionary["id"] as?  String,
                      let name = dictionary["name"] as? String,
                      let otherUserEmail = dictionary["other_user_email"] as? String,
                      let latestMessage = dictionary["latest_message"] as? [String:Any],
                      let date = latestMessage["date"] as? String,
                      let message = latestMessage["message"] as? String,
                      let isRead = latestMessage["is_read"] as? Bool else {
                    return nil
                }
                //모델을 생성하고 반환
                let latestMessageObject = LatestMessage(date: date, text: message, isRead: isRead)
                return Conversation(id: conversationId, name: name, otherUserEmail: otherUserEmail, latestMessage: latestMessageObject)
            })
            completion(.success(conversations))
        })
    }
    //보낸 사람의 대화 목록의 모든 메시지를 가져옵니다.
    public func getAllMessagesForConversation(with id: String, completion: @escaping (Result<String, Error>) -> Void) {
        
    }
    //대상 대화목록과 메시지를 보냅니다.
    public func sendMessage(to conversation: String, message: Message, completion: @escaping (Bool) -> Void) {
        
    }
    
    
    
}


