//
//  CurrentWeather.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/15.
//

import Foundation
import SwiftyJSON
import Alamofire

class CurrentWeather {
    
    private var _cityName: String!
    private var _date: String!
    private var _weatherType: String!
    private var _currentTemp: Double!
    
    // 옵셔널 바인딩 /값이 없을경우
    var cityName: String {
        if _cityName == nil {
            _cityName = "옵셔널 입니다."
        } else {
            return _cityName
            
        }
        return _cityName
    }

    var date: String {
        return _date ?? ""
    }
    var weatherType: String {
        return _weatherType ?? ""
    }

    var currentTemp: Double {
        return _currentTemp ?? 0.0
    }
    func downloadCurrentWeather(completion: @escaping () -> Void) {
        //URL을 기반으로 JSON데이터를 불러 오고 값을 저장해줍니다.
        AF.request(API_URL).responseData { response in
            let jsonObject = JSON(response.data!)
           // print(jsonObject)
            //도시 이름
            self._cityName = jsonObject["name"].stringValue
            //날씨 정보
            self._weatherType = jsonObject["weather"][0]["description"].stringValue
            //온도 정보
            let tempDate = jsonObject["dt"].double
            let downloadTemp = jsonObject["main"]["temp"].double
            self._currentTemp = downloadTemp!.kelvinToCelsius.rounded(toplaces: 0)
            //날짜
            let convertedUnixDate = Date(timeIntervalSince1970: tempDate!)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            let currnetDate = dateFormatter.string(from: convertedUnixDate)
            self._date = "\(currnetDate)"
            
            print(self.cityName)
            print(self.date)
            print(self.weatherType)
            print(self.currentTemp)
            completion()
        }
    }
}
