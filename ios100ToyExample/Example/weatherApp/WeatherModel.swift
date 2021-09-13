//
//  WeatherModel.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/14.
//

import Foundation


class WeatherViewModel {
    ///데이터가 완료 되었을 때 다시 업데이트 하기 위한 모델입니다.
    private var main: Weather.Main? {
        return weather?.main
    }
    
    var weather: Weather?
    var temperatureString: String {
        return String(main?.temp ?? 0)
    }
    var cityString: String {
        return String(weather?.name ?? "")
    }
    
    
    func fetchWeather(for cityId: Int = 1835848, _ completion: @escaping (() -> Void)) {
        NetworkController.fetchWeather(for: cityId) { weather in
            self.weather = weather
            completion()
        }
    }
    
}
