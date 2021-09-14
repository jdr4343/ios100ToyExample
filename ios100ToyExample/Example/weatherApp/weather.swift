//
//  weather.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/14.
//

//{
//  "coord": {
//    "lon": -122.08,
//    "lat": 37.39
//  },
//  "weather": [
//    {
//      "id": 800,
//      "main": "Clear",
//      "description": "clear sky",
//      "icon": "01d"
//    }
//  ],
//  "base": "stations",
//  "main": {
//    "temp": 282.55,
//    "feels_like": 281.86,
//    "temp_min": 280.37,
//    "temp_max": 284.26,
//    "pressure": 1023,
//    "humidity": 100
//  },
//  "visibility": 16093,
//  "wind": {
//    "speed": 1.5,
//    "deg": 350
//  },
//  "clouds": {
//    "all": 1
//  },
//  "dt": 1560350645,
//  "sys": {
//    "type": 1,
//    "id": 5122,
//    "message": 0.0139,
//    "country": "US",
//    "sunrise": 1560343627,
//    "sunset": 1560396563
//  },
//  "timezone": -25200,
//  "id": 420006353,
//  "name": "Mountain View",
//  "cod": 200
//  }

import Foundation

//위의 코드를 기반으로 디코딩 합니다.
struct Weather: Decodable {
    var name: String
    var main: Main
    
    //구현 대기
    var weather: [weather]

    struct weather: Decodable {
        var id: Int
        var main: String
        var description: String
        var icon: String
    
    struct Main: Decodable {
        var temp: Double
        var feelsLike: Double
        var tempMin: Double
        var tempMax: Double
        var pressure: Int
        var humidity: Int
        //카멜케이스 유형으로 사용하기 위해서 위의 키들을 카멜케이스를 적용시켜 입력하고 아래의 코드를 이용해 적용 시켜주겠습니다.
        enum CodingKeys: String, CodingKey {
            case feelsLike = "feels_like"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case temp
            case pressure
            case humidity
        }
    }
}
extension Weather {
    var temp: Double {
        return main.temp
    }
    var feelsLike: Double {
        return main.feelsLike
    }
    var tempMin: Double {
        return main.tempMin
    }
    var tempMax: Double {
        return main.tempMax
    }
    var pressure: Int {
        return main.pressure
    }
    var humidity: Int {
        return main.humidity
    }
}
