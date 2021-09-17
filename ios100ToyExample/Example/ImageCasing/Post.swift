//
//  Post.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/18.
//

import Foundation

///사진을 게시한 사용자 프로필 이미지
struct PostUserProfileImage: Codable {
    let medium: String
}
struct PostUser: Codable {
    let profile_image: PostUserProfileImage
}

///사진 URL
struct PostUrls: Codable {
    let regular: String
}

///게시 정보
struct Post: Codable {
    let id: String
    let description: String?
    let user: PostUser
    let urls: PostUrls
}
