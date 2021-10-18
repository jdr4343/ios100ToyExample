//
//  Location.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/15.
//

import Foundation

class WeatherLocation {
    //공유 인스턴스
    static var shared = WeatherLocation()
    
    var longitude: Double!
    var latitude: Double!
}
