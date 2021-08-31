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
        database.child(email.safeDatabaseKey()).observeSingleEvent(of: .value, with: { snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            completion(true)
        })
    }
    
    
    public func insertNewUser(with user: UserModel) {
        //노드 삽입 / 키가 이메일이될 자식함수를 생성합니다.
        database.child(user.emailAdress.safeDatabaseKey()).setValue(["name": user.username])
        }
    }




//MARK: - extention

////firebase의 데이터 베이스에는 마침표를 사용할수 없습니다. 따라서 그냥 email을 child에 삽입 할경우 에러가 나기 때문에 안전한 이메일을 생성하는 함수를 만들어 줘야 합니다.
extension String {
    func safeDatabaseKey() -> String {
        return self.replacingOccurrences(of: "@", with: "-").replacingOccurrences(of: ".", with: "-")
    }
}

