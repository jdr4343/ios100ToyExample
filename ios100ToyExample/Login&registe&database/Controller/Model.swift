//
//  Model.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/30.
//

import Foundation

//MARK: - 게시물

//사용자가 포스팅할 게시물에 대한 타입입니다.
public enum UserPostType: String {
    case photo = "Photo"
    case write = "Write"
}

//사용자 게시물을 나타내는 모델입니다.
public struct UserPost {
    let identifier: String //게시물에 대한 식별자 입니다.
    let postType: UserPostType // 게시물 타입입니다. 사진 혹은 글이 될수 있습니다.
    let postURL: String? // 파이어 베이스에서 받아올 사진 URL입니다.
    let caption: String? // 사용자가 남길 부연 설명입니다.
    let likeCount: [PostLikes] // 사용자의 게시물을 좋아요한 숫자를 샙니다.
    let createDate: Date // 날짜를 기록 합니다.
    let toggedUser: [String]
    let owner: UserModel // 글쓴이 에대한 데이터 입니다.
}

struct PostLikes {
    let userName: String
    let postIdentifire: String
}

//MARK: - 회원 정보

struct UserModel {
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
