//
//  Events.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/11.
//

import Foundation

class Event<T> {
    let identifier: String
    //결과 유형은 성공 및 오류 유형을 취해야 함으로 제네릭과 옵셔널 값을 줍니다.
    let result: Result<T, Error>?
    
    //초기화 하여 줍니다.
    init(identifier:String, result: Result<T, Error>?) {
        self.identifier = identifier
        self.result = result
        
    }
}

///이벤트의 하위 클래스 입니다.사용자 베열을 가져오는 이벤트 클래스 입니다.
class UserFetchEvent: Event<[User]> {
    
    
}

///API 호출을 해서 받아온 모의 사용자 배열을 담을 모델을 만들어 줍니다. 이름 유형의 단일 속성을 가집니다.
struct User: Codable {
    let name: String
}
