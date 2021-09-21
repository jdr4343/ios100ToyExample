//
//  WeatherExtra.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/15.
//

import Foundation
///예제에서 만든 날씨앱과 같은 API를 사용하여 좌표에 따라 날씨 정보가 변하는 화면을 구성합니다.




let API_URL = "http://api.openweathermap.org/data/2.5/weather?lat=\(WeatherLocation.shared.latitude ?? 37.33233141)&lon=\(WeatherLocation.shared.longitude ?? -122.0312186)&appid=f5220d65cf537cfb942a8920b1829833&lang=kr"


