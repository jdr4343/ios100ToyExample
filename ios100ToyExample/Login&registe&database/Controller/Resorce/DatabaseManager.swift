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
    
    //재사용 가능한 속성으로 만들겠습니다. //실험 실패시 지울것
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
    
    
    public func insertNewUser(with user: UserModel, complation: @escaping (Bool) -> Void) {
        //노드 삽입 / 키가 이메일이될 자식함수를 생성합니다. / 사용자가 다른 플랫폼을 통해서 로그인 할경우 사용자가 프로필 사진이 있는지 확인합니다. 삭제?
        database.child(user.safeEmail).setValue(["name": user.username], withCompletionBlock: { error, _ in
            guard error == nil else {
                print("Database - 58 데이터 베이스를 읽지 못했습니다.")
                complation(false)
                return
            }
            complation(true)
        })
    }
}



