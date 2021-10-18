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
