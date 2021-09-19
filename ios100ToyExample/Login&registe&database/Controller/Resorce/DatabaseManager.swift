//
//  DatabaseManager.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/25.
//

import FirebaseDatabase
import FirebaseFirestore
import MessageKit
import CoreLocation

///파이어베이스 데이터 기반으로 데이터를 읽고 쓰기를 할 관리자 개체 입니다.
final class DatabaseManager {
    
    ///공유 클래스 인스턴스
    static let shared = DatabaseManager()
    
    //데이터 베이스를 사용하기 위해 데이터베이스를 참조 하겠습니다.
    private let database = Database.database().reference()
    private let fireStore = Firestore.firestore()
    
    private init() {}
    
    //재사용 가능한 속성으로 만들겠습니다. 
    static func safeEmail(emailAddress: String) -> String {
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
  
    public func canCreateNewUser(with email: String, username: String, completion: (Bool) -> Void) {
        completion(true)
    }
    
}

extension DatabaseManager {
    ///하위 경로의 dictionary 노드를 반환합니다.
    public func getDataFor(path: String, completion: @escaping (Result<Any,Error>) -> Void) {
        self.database.child("\(path)").observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value else {
                completion(.failure(DatabaseError.failedToFetch))
                return
            }
            completion(.success(value))
            
        }
    }
}


//MARK: - 계정 관리

extension DatabaseManager {
    
    ///신규 회원가입 유저의 데이터를 데이터베이스에 추가합니다.
    ///-parameter
    ///    -email: 이메일을 나타내는 문자열입니다.
    ///    -username: 유저이름을 나타내는 문자열입니다
    ///    -completion: 데이터베이스 입력이 성공한 경우 결과에 대한 비동기 콜백입니다.
    
    /// 이메일을 사용할수 있는지 확인합니다.
    /// -parameter
    ///    `email`: 이메일을 나타내는 문자열입니다.
    ///    `completion`: 결과에 대한 비동기 클로저입니다.
    public func userExists(with email: String, completion: @escaping ((Bool) -> Void)) {
        let safeEmail = DatabaseManager.safeEmail(emailAddress: email)
        
        database.child(safeEmail).observeSingleEvent(of: .value, with: { snapshot in
            guard snapshot.value as? [String: Any] != nil else {
                completion(false)
                return
            }
            completion(true)
        })
    }
    
    //새로운 사용자 개체가 생성되면 user 컬렉션에 추가합니다
    public func insertNewUser(with user: User, completion: @escaping (Bool) -> Void) {
        //노드 삽입 / 키가 이메일이될 자식함수를 생성합니다. / 사용자가 다른 플랫폼을 통해서 로그인 할경우 사용자가 프로필 사진이 있는지 확인합니다. 삭제?
        database.child(user.safeEmail).setValue(["name": user.username], withCompletionBlock: { [weak self] error, _ in
            guard let strongSelf = self else {
                return
            }
            guard error == nil else {
                print("Database - 58 데이터 베이스를 읽지 못했습니다.")
                completion(false)
                return
            }
            completion(true)
            //이벤트를 관찰합니다.
            strongSelf.database.child("users").observeSingleEvent(of: .value, with: { snapshot in
                if var usersCollection = snapshot.value as? [[String:String]] {
                    //이중 dictionary 컬렉션 형식으로 두개의 node를 추가합니다. 키도 문자열 값도 문자열입니다.노드 창이 두개인 이유는 대화하는 발신자와 수신자를 구별하기 위해서 입니다.
                    let newElement = [
                        "name": user.username,
                        "email": user.safeEmail
                    ]
                    usersCollection.append(newElement)
                    //사용자가 참조 할수 있도록 firebase에 추가합니다.
                    strongSelf.database.child("users").setValue(usersCollection, withCompletionBlock: { error, _ in
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
                    strongSelf.database.child("users").setValue(newCollection, withCompletionBlock: { error, _ in
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
    
    ///데이터베이스에서 모든 사용자 데이터를 가져옵니다.
    public func getAllUsers(completion: @escaping (Result<[[String:String]], Error>) -> Void) {
        database.child("users").observeSingleEvent(of: .value, with: { snapshot in
            guard let value = snapshot.value as? [[String:String]] else {
                completion(.failure(DatabaseError.failedToFetch))
                return
            }
            //값을 전달합니다.
            completion(.success(value))
        })
    }
    
    ///오류 정의
    public enum DatabaseError: Error {
        case failedToFetch
        
        //구현대기 /나중에 에러 케이스 가져와서 정리하기
        var localizedDescription: String {
            switch self {
            case .failedToFetch:
                return "블라블라"
            }
        }
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
        guard let currentEmail = UserDefaults.standard.value(forKey: "email") as? String,
              let currentname = UserDefaults.standard.value(forKey: "name") as? String else {
            return
        }
        let safeEmail = DatabaseManager.safeEmail(emailAddress: currentEmail)
        let ref = database.child("\(safeEmail)")
        ref.observeSingleEvent(of: .value, with: { [weak self] snapshot in
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
            
            
            //현재 사용자에 대한 대화 배열을 추가합니다.
            if var conversations = userNode["conversations"] as? [[String: Any]] {
                
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
            
            //수신자의 화면에도 채팅을 띄우기 위해 받은 수신자에게도 노드를 만들어 주겠습니다.
            let recipient_newConversationData: [String: Any] =
                [
                    "id": conversationID,
                    "other_user_email": safeEmail,
                    "name": currentname,
                    "latest_message":
                        [
                            "date": dateString,
                            "message": message,
                            "is_read": false
                        ]
                ]
            
            //수신인 사용자 대화 배열을 업데이트 합니다.
            self?.database.child("\(otherUserEmail)/conversations").observeSingleEvent(of: .value, with: { [weak self] snapshot in
                if var conversations = snapshot.value as? [[String: Any]] {
                    //추가
                    conversations.append(recipient_newConversationData)
                    self?.database.child("\(otherUserEmail)/conversations").setValue(conversations)
                } else {
                    //생성
                    self?.database.child("\(otherUserEmail)/conversations").setValue([recipient_newConversationData])
                }
            })
            
            
            
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
        //날짜
        let messageDate = firstMessage.sentDate
        let dateString = ChatViewController.dateFormatter.string(from: messageDate)
        
        
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
    public func getAllMessagesForConversation(with id: String, completion: @escaping (Result<[Message], Error>) -> Void) {
        database.child("\(id)/messages").observe(.value, with: { snapshot in
            guard let value = snapshot.value as? [[String: Any]] else {
                completion(.failure(DatabaseError.failedToFetch))
                return
            }
            let messages: [Message] = value.compactMap({ dictionary in
                guard let name = dictionary["name"] as? String,
                      let isRead = dictionary["is_read"] as? Bool,
                      let messageId = dictionary["id"] as? String,
                      let content = dictionary["content"] as? String,
                      let senderEmail = dictionary["sender_email"] as? String,
                      let type = dictionary["type"] as? String,
                      let dateString = dictionary["date"] as? String ,
                      let date = ChatViewController.dateFormatter.date(from: dateString) else {
                    return nil
                }
                
                //사용자가 보내는 메시지의 타입의 유형을 검사 하겠습니다.
                var kind: MessageKind?
                //사진 유형
                if type == "photo" {
                    guard let imageUrl = URL(string: content),
                          let placehorder = UIImage(systemName: "plus") else {
                        return nil
                    }
                    let media = Media(url: imageUrl,
                                      image: nil,
                                      placeholderImage: placehorder,
                                      size: CGSize(width: 300, height: 300))
                    kind = .photo(media)
                    
                    //비디오 유형
                } else if type == "video" {
                    guard let videoUrl = URL(string: content),
                          let placehorder = UIImage(named: "비디오플레이어") else {
                        return nil
                    }
                    let media = Media(url: videoUrl,
                                      image: nil,
                                      placeholderImage: placehorder,
                                      size: CGSize(width: 300, height: 300))
                    kind = .video(media)
                  //위치 정보 유형
                } else if type == "location" {
                    let locationComponents = content.components(separatedBy: ",")
                    guard let longitude = Double(locationComponents[0]),
                          let latitude = Double(locationComponents[1]) else {
                        return nil
                    }
                    
                    let location = Location(location: CLLocation(latitude: latitude, longitude: longitude),
                                                                 size: CGSize(width: 300, height: 300))
                                            
                    kind = .location(location)
                }
                //텍스트 유형
                else {
                    kind = .text(content)
                }
                
                guard let finalKind = kind else {
                    return nil
                }
                
                
                //모델을 생성하고 반환
                let sender = Sender(photoURL: "", senderId: senderEmail, displayName: name)
                
                return Message(sender: sender, messageId: messageId, sentDate: date, kind: finalKind)
            })
            completion(.success(messages))
        })
    }
    
    //대상 대화목록과 메시지를 보냅니다.
    public func sendMessage(to conversation: String, otherUserEmail: String , name: String, newMessage: Message, completion: @escaping (Bool) -> Void) {
        
        //현재 사용자를 언래핑하고 안전한 이메일로 바꿔줍니다.
        guard let myEmail = UserDefaults.standard.value(forKey: "email") as? String else {
            completion(false)
            return
        }
        let currentEmail = DatabaseManager.safeEmail(emailAddress: myEmail)
        
        //답신이 가능하도록 새롭게 메시지를 추가합니다. 먼저 대화의 현재 메시지 배열을 가져옵니다.
        database.child("\(conversation)/messages").observeSingleEvent(of: .value, with: { [weak self] snapshot in
            guard let strongSelf = self else {
                return
            }
            guard var currentMessages = snapshot.value as? [[String: Any]] else {
                completion(false)
                return
            }
            //날짜
            let messageDate = newMessage.sentDate
            let dateString = ChatViewController.dateFormatter.string(from: messageDate)
            
            
            //메시지 내용. //사진 기반 메시지를 보내도록 조정합니다.
            var message = ""
            switch newMessage.kind {
            case .text(let messageText):
                message = messageText
            case .attributedText(_):
                break
            case .photo(let mediaItem):
                if let targetUrlString = mediaItem.url?.absoluteString {
                    message = targetUrlString
                }
                break
            case .video(let mediaItem):
                if let targetUrlString = mediaItem.url?.absoluteString {
                    message = targetUrlString
                }
                break
            case .location(let locationData):
                let location = locationData.location
                    //위도,경도 수행
                    message = "\(location.coordinate.longitude),\(location.coordinate.latitude)"
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
            
            //보낸사람 지정 / email 형식을 안전한 이메일로 지정
            guard let myEmail = UserDefaults.standard.value(forKey: "email") as? String else {
                completion(false)
                return
            }
            let currentUserEmail = DatabaseManager.safeEmail(emailAddress: myEmail)
            
            let newMessageEntry: [String: Any] = [
                "id": newMessage.messageId,
                "type": newMessage.kind.messageKindString,
                "content": message,
                "date": dateString,
                "sender_email": currentUserEmail,
                "is_read": false,
                "name": name
            ]
            
            //메시지를 추가 합니다.
            currentMessages.append(newMessageEntry)
            strongSelf.database.child("\(conversation)/messages").setValue(currentMessages) { error, _ in
                guard error == nil else {
                    completion(false)
                    return
                }
                //보낸사람의 최신 메시지를 업데이트 합니다. 최신 메시지를 업데이트 함으로서 연락을 보내거나 받을떄 최신의 메시지가 화면에 보이게 할 것입니다.
                //각 현재 사용자에 대한 대화노드를 얻고 / 해당 노드를 strongSelf로 선언 하고 현재 이메일을 단일이벤트를 옵저빙 하겠습니다.
                strongSelf.database.child("\(currentEmail)/conversations").observeSingleEvent(of: .value, with: { snapshot in
                    var databaseEntryConversations = [[String: Any]]()
                    
                    //conversationId의 항목의 대화 배열에서 최신 메시지를 업데이트 하겠습니다.
                    let updateValue: [String: Any] = [
                        "date": dateString,
                        "is_read": false,
                        "message": message
                    ]
                    
                    if var currentUserConversations = snapshot.value as? [[String: Any]]  {
                        var targetConversation: [String: Any]?
                        var position = 0
                        
                        for conversationDictionary in currentUserConversations {
                            if let currentId = conversationDictionary["id"] as? String, currentId == conversation {
                                targetConversation = conversationDictionary
                                break
                            }
                            position += 1
                        }
                        if var targetConversation = targetConversation {
                            targetConversation["latest_message"] = updateValue
                            currentUserConversations[position] = targetConversation
                            databaseEntryConversations = currentUserConversations
                        } else {
                            let newConversationData: [String: Any] =
                                [
                                    "id": conversation,
                                    "other_user_email": DatabaseManager.safeEmail(emailAddress: otherUserEmail),
                                    "name": name,
                                    "latest_message": updateValue
                                ]
                            currentUserConversations.append(newConversationData)
                            databaseEntryConversations = currentUserConversations
                        }
                        
                        
                        
                    } else {
                        let newConversationData: [String: Any] =
                            [
                                "id": conversation,
                                "other_user_email": DatabaseManager.safeEmail(emailAddress: otherUserEmail),
                                "name": name,
                                "latest_message": updateValue
                            ]
                        //사용자가 기존 대화를 지우고 새롭게 대화했던 상대와 대화를 시작할때의 배열이 될 것 입니다.
                        //이렇게 새 배열을 만드는 이유는 중복을 피하기 위해서 입니다. 기술적으로 사용자는 대화를 지웠다고 생각하겠지만 상대방에게는 대화가 남아 있을것 이므로 사용자가 기존 대화를 지우고 다시 대화를 시작할 경우 중복이 일어날것이기 떄문입니다.
                        databaseEntryConversations = [newConversationData]
                    }
                    
                    
                    strongSelf.database.child("\(currentEmail)/conversations").setValue(databaseEntryConversations) { error, _ in
                        guard error == nil else {
                            completion(false)
                            return
                        }
                        
                        
                        //받는사람의 최신 메시지르 업데이트 합니다.
                        
                        strongSelf.database.child("\(otherUserEmail)/conversations").observeSingleEvent(of: .value, with: { snapshot in
                            //conversationId의 항목의 대화 배열에서 최신 메시지를 업데이트 하겠습니다.
                            let updateValue: [String: Any] = [
                                "date": dateString,
                                "is_read": false,
                                "message": message
                            ]
                            var databaseEntryConversations = [[String: Any]]()
                            
                            guard let currentName = UserDefaults.standard.value(forKey: "name") as? String else {
                                return
                            }
                            
                            if var otherUserConversations = snapshot.value as? [[String: Any]]  {
                                 
                                var targetConversation: [String: Any]?
                                var position = 0
                                
                                for conversationDictionary in otherUserConversations {
                                    if let currentId = conversationDictionary["id"] as? String, currentId == conversation {
                                        targetConversation = conversationDictionary
                                        break
                                    }
                                    position += 1
                                }
                                
                                if var targetConversation = targetConversation {
                                    targetConversation["latest_message"] = updateValue
                                    otherUserConversations[position] = targetConversation
                                    databaseEntryConversations = otherUserConversations
                                }
                                else {
                                print("현재 컬렉션에서 찾는것에 실패 했습니다.")
                                    let newConversationData: [String: Any] =
                                        [
                                            "id": conversation,
                                            "other_user_email": DatabaseManager.safeEmail(emailAddress: currentEmail),
                                            "name": currentName,
                                            "latest_message": updateValue
                                        ]
                                    otherUserConversations.append(newConversationData)
                                    databaseEntryConversations = otherUserConversations
                                }
                            }
                            else {
                                print("현재 컬렉션이 존재하지 않습니다.")
                                let newConversationData: [String: Any] =
                                    [
                                        "id": conversation,
                                        "other_user_email": DatabaseManager.safeEmail(emailAddress: currentEmail),
                                        "name": currentName,
                                        "latest_message": updateValue
                                    ]
                                //사용자가 기존 대화를 지우고 새롭게 대화했던 상대와 대화를 시작할때의 배열이 될 것 입니다.
                                //이렇게 새 배열을 만드는 이유는 중복을 피하기 위해서 입니다. 기술적으로 사용자는 대화를 지웠다고 생각하겠지만 상대방에게는 대화가 남아 있을것 이므로 사용자가 기존 대화를 지우고 다시 대화를 시작할 경우 중복이 일어날것이기 떄문입니다.
                                databaseEntryConversations = [newConversationData]
                            
                            
                            }
                          
                            
                          
                            strongSelf.database.child("\(otherUserEmail)/conversations").setValue(databaseEntryConversations) { error, _ in
                                guard error == nil else {
                                    completion(false)
                                    return
                                }
                                completion(true)
                            }
                        })
                    }
                })
            }
        })
    }
    
    //MARK: - 대화 목록 삭제
    
    public func deleteConverstion(conversationId: String, completion: @escaping (Bool) -> Void ) {
        guard let email = UserDefaults.standard.value(forKey: "email") as? String else {
            return
        }
        let safeEmail = DatabaseManager.safeEmail(emailAddress: email)
        print("\(conversationId)와의 대화를 삭제합니다.")
        
        //현재 사용자의 모든 대화 목록을 가져옵니다
        //대상 ID가 있는 컬렉션에서 대화를 삭제합니다.
        //데이터베이스의 사용자에 대한 대화를 재설정합니다.
        let ref = database.child("\(safeEmail)/conversations")
        ref.observeSingleEvent(of: .value) { snapshot in
            if var conversations = snapshot.value as? [[String: Any]] {
                var positionToRemove = 0
                for conversation in conversations {
                    if let id = conversation["id"] as? String,
                       id == conversationId {
                        print("삭제할 대화를 찾았습니다.")
                        break
                    }
                    positionToRemove += 1
                }
                conversations.remove(at: positionToRemove)
                ref.setValue(conversations,withCompletionBlock: { error, _ in
                    guard error == nil else {
                        completion(false)
                        print("대화를 삭제하는데 실패 했습니다.")
                        return
                    }
                    print("대화가 삭제 되었습니다.")
                    completion(true)
                })
            }
        }
        
    }
    

    //MARK: - 검색시 진행중인 대화 목록이 있을 경우 존재하는 대화 데이터베이스와 재사용 합니다.
    
    public func conversationExists(with targetRecipientEmail: String, completion: @escaping (Result<String, Error>) -> Void) {
        let safeRecipientEmail = DatabaseManager.safeEmail(emailAddress: targetRecipientEmail)
        guard let senderEmail = UserDefaults.standard.value(forKey: "email") as? String else {
            return
        }
        let safeSenderEmail = DatabaseManager.safeEmail(emailAddress: senderEmail)
        
        database.child("\(safeRecipientEmail)/conversations").observeSingleEvent(of: .value, with: { snapshot in
            guard let collection = snapshot.value as? [[String: Any]] else {
                completion(.failure(DatabaseError.failedToFetch))
                return
            }
            //진행중인 대화를 찾으면 연결 합니다.
            if let conversation = collection.first(where: {
                guard let targetSenderEmail = $0["other_user_email"] as? String else {
                    return false
                }
                return safeSenderEmail == targetSenderEmail
            }) {
                //id를 얻습니다.
                guard let id = conversation["id"] as? String else {
                    completion(.failure(DatabaseError.failedToFetch))
                    return
                }
                //id를 전달 합니다.
                completion(.success(id))
                return
            }
            completion(.failure(DatabaseError.failedToFetch))
            return
        })
    }
}

//MARK: FeedPost
extension DatabaseManager {
    ///새로운 게시물을 추가합니다.
    public func insert(feedPost: BlogPost, user: User, completion: @escaping (Bool) -> Void) {
        
    }

    ///모든 게시물을 불러와 시간순으로 정렬 합니다.
    public func getAllPost(completion: @escaping ([BlogPost]) -> Void) {
        
    }
    
    ///프로필에서 사용자에 대한 게시물을 볼수 있도록 합니다.
    public func getPosts(for user: User, completion: @escaping ([BlogPost]) -> Void) {
        
    }
    
//    ///프로필에서 사용자에 대한 게시물을 볼수 있도록 합니다.
//    public func insertUser(user: User, completion: @escaping (Bool) -> Void) {
//
//    }
}
