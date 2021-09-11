//
//  Bus.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/11.
//

import Foundation
import UIKit
//정보 전송을 버스라고 합니다.

class Bus {
    ///특정 이벤트의 가입 및 게재을 담당하는 정보 전송 합니다.
    
    static let shared = Bus()
    
    private init() {}
    
    ///가입을 시도할때 마다 모델에 게재 합니다.
    private var subscriptions = [Subscription]()
    
    enum EventType {
        case userFetch
    }
    
    struct Subscription {
        let type: EventType
        let queue: DispatchQueue
        let block: ((Event<Any>) -> Void)
    }
    
    ///특정 유형의 이벤트를 구독합니다. @escaping을 사용하여 반환할수 있습니다.
    func subscribe(_ event: EventType, block: @escaping (Event<Any>) -> Void) {
        let new = Subscription(type: event,
                               queue: .global(),
                               block: block)
        //가입을 하면 모델에 추가 합니다.
        subscriptions.append(new)
    }
    func subscribeOnMain(_ event: EventType, block: @escaping (Event<Any>) -> Void) {
        let new = Subscription(type: event,
                               queue: .main,
                               block: block)
        //가입을 하면 모델에 추가 합니다.
        subscriptions.append(new)
    }
    
    
    func publish(_ event: Event<Any>) {
        
    }
}
