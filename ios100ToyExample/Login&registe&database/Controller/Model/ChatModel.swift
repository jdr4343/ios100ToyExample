//
//  ChatModel.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/09.
//

import Foundation
import MessageKit
import CoreLocation

//메시지
struct Message: MessageType {
    public var sender: SenderType //보낸사람
    public var messageId: String //이메일
    public var sentDate: Date //날짜
    public var kind: MessageKind //메시지 종류
}
//메시지 종류 확장 / 문자열 속성으로 바꿔줍니다.
extension MessageKind {
    var messageKindString: String {
        switch self {
        case .text(_):
            return "text"
        case .attributedText(_):
            return "attributedText"
        case .photo(_):
            return "photo"
        case .video(_):
            return "video"
        case .location(_):
            return "location"
        case .emoji(_):
            return "emoji"
        case .audio(_):
            return "audio"
        case .contact(_):
            return "contact"
        case .linkPreview(_):
            return "linkPreview"
        case .custom(_):
            return "custom"
        }
    }
}

//보낸사람
struct Sender: SenderType {
    public var photoURL: String //프로필 사진
    public var senderId: String //이메일
    public var displayName: String //유저이름
}

//미디어 / 사진 비디오 등등
struct Media: MediaItem {
    var url: URL?
    var image: UIImage?
    var placeholderImage: UIImage
    var size: CGSize

}

//위치
struct Location: LocationItem {
    var location: CLLocation
    var size: CGSize
}

//오디오 // 구현대기
struct Audio: AudioItem {
    var url: URL
    var duration: Float
    var size: CGSize
}

