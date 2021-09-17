//
//  NewsModel.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/19.
//

import Foundation

//MARK: - Models
//Codable 은 데이터를 다른 데이터 형태로 변환할수 있는 기능의 Encodeable이나 반대의 기능의 Decodeable을 합한 타입입니다.
//api의 내용에 스위프트의 타입을 지정해줄것입니다.
 struct APIResponse: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let source: Source
    let title: String
    let description: String
    let url: String
    let urlToImage: String
    let publishedAt: String
    let content: String
}
//우리는 id는 사용하지 않으므로 id는 제외 하겠습니다.
struct Source: Codable {
    let name: String
}

class NewsTableViewCellViewModel {
    let title: String
    let subtitle: String
    let imageURL: URL?
    var imageData: Data? = nil
    
    init(
        title: String,
        subtitle: String,
        imageURL: URL?
    ) {
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
    }
}
