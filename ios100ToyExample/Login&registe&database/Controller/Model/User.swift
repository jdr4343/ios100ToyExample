//
//  Model.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/30.
//

import Foundation


//MARK: - 회원 정보

struct User {
    let username: String
    let emailAddress: String
    
    var safeEmail: String {
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
    
    var profilePictureFileName: String {
        return "\(safeEmail)_profile_picture.png"
    }
    
}



struct EditProfileFormModel {
    let label: String
    let placeholder: String?
    var value : String?
}

extension Notification.Name {
    ///사용자가 로그인 하면 알수 있습니다.
    static let didLogInNotification = Notification.Name("didLogInNotification")
}



