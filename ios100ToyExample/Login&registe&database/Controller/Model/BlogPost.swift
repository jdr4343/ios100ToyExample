//
//  Post.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/19.
//

import UIKit

struct BlogPost {
    let identifier: String
    let title: String //게시물 제목
    let timestamp: TimeInterval //게시물 생성 날짜
    let headerImageUrl: URL?
    let text: String
}

