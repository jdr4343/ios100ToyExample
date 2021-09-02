//
//  AuthManager.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/25.
//
//이 파일에서는 인증 항목을 관리할 파일을 만듭니다! 다른 뷰에서도 사용할수 있도록 모두 public으로 선언할 예정 입니다
import FirebaseAuth
import UIKit
public class AuthManager {
    static let shared =  AuthManager()

    
//    public func registerNewUser(username: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
//        ///-사용자이름을 사용할수 있는지 확입합니다.
//        ///-아메일을 사용할수 있는지 확인합니다. /계정당 하나의 이메일만 연결 할수 있습니다.
//        DatabaseManager.shared.canCreateNewUser(with: email, username: username) { canCreate in
//            if canCreate {
//
//                DatabaseManager.shared.userExists(with: email, completion: { exists in
//                    guard !exists else {
//                        return
//                    }
//                    ///-계정을 생성합니다.
//                    ///-데이터베이스에 계정을 등록합니다.
//                    Auth.auth().createUser(withEmail: email, password: password) {  authResult , error in
//                        guard authResult != nil ,error == nil else {
//                            print("Auth19 - 계정을 만들수 없습니다.")
//                            completion(false)
//                            return
//                        }
//
//
//                        ///데이터 베이스에 등록  // 구현대기 만들던 도중 나의 레지스터 뷰 에는 이미지 뷰가 없고 바꿀 팔요가 없어서 구현을 안함 추후 문제가 있다면 레지스터뷰를 이사해서 구현해야할듯
//                        DatabaseManager.shared.insertNewUser(with: UserModel(username: username, emailAddress: email), complation: { success in
////                            if success {
////                                //사진을 업로드 합니다.
////                                guard let image = self.imageView.image,
////                                      let data = image.pngData() else {
////                                    return
////                                }
////                                let fileName
//
//
//      //                      }
//                        })
//
//                    }
//                })
//
//
//            } else {
//                print("Auth36 - 유저 이름 또는 이메일이 잘못되었습니다")
//                completion(false)
//            }
//        }
//    }
    ///로그인
    public func loginUser(username: String?, email: String?, password: String, completion: @escaping (Bool) -> Void) {
        if let email = email {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                
                //인증 결과가 nil이 아니고 오류가 nil과 같을떄 completion(true)를 호출하고 else라면 false를 반환 합니다!
                guard authResult != nil, error == nil else {
                    print("Auth51 - \(email) 로그인이 실패 했습니다")
                    completion(false)
                    return
                }
                
                print("\(email)가 로그인 하였습니다.")
                completion(true )
            }
        } else if let username = username {
            print(username)
        }
    }
    ///로그아웃
    public func logOut(completion: (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true)
            return
        }
        catch {
            print("로그아웃에 실패 했습니다.")
            completion(false)
            return
        }
    }
 
    
    
    
}
