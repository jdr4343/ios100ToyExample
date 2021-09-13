//
//  Bus.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/11.
//

import Foundation
import UIKit
//정보 전송을 버스라고 합니다.

final class Bus {
    ///특정 이벤트의 가입 및 사용자 등록 정보를 전송 합니다.
    
    static let shared = Bus()
    
    private init() {}
    
    ///가입을 시도할때 마다 모델에 등록 합니다.
    private var subscriptions = [Subscription]()
    
    enum EventType {
        //사용자 등록 이벤트
        case userFetch
    }
    
    struct Subscription {
        let type: EventType //이벤트 타입
        let queue: DispatchQueue // 큐 발송
        let block: ((Event<[User]>) -> Void) //핸들러
    }
    
    ///특정 유형의 이벤트를 시작합니다. 저희의 경우에는 사용자 등록 정보를 전송하는 이벤트를 실행합니다.
    func subscribe(_ event: EventType, block: @escaping (Event<[User]>) -> Void) {
        let new = Subscription(type: event,
                               queue: .global(),
                               block: block)
        //가입을 하면 모델에 추가 합니다.
        subscriptions.append(new)
    }
    func subscribeOnMain(_ event: EventType, block: @escaping (Event<[User]>) -> Void) {
        let new = Subscription(type: event,
                               queue: .main,
                               block: block)
        //가입을 하면 모델에 추가 합니다.
        subscriptions.append(new)
    }
    
    ///가입을 한후 특정 이벤트를 시작합니다. 중요한 사항은 전달된 스레드에 관계 없이 호출 됩니다.
    func publish(type: EventType, event: UserFetchEvent) {
        //필터(filter)를 통해 내부의 값을 걸러서 추출(반환타입은 bool입니다)/ 단축 인자($0)를 통해 클로저 간소화
        let subscribers = subscriptions.filter({ $0.type == type })
            //시퀀스의 각 요소에 대해 루프와 동일한 순서로 호출 합니다.
        subscribers.forEach { subscribers in
            //비동기식으로 이벤트를 전달 합니다.
            subscribers.queue.async {
                subscribers.block(event)
            }
        }
    }
}

//컨트롤러와 보기 모델에 연결 하도록 하겠습니다.
