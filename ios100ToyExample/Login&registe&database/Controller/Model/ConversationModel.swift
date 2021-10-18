//
//  ConversationModel.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/09.
//

import Foundation


//노드의 conversations를 가져옵니다.
struct Conversation {
    let id: String
    let name: String
    let otherUserEmail: String
    let latestMessage: LatestMessage
}

struct LatestMessage {
    let date: String
    let text: String
    let isRead: Bool
}

