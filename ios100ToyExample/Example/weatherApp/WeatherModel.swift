//
//  WeatherModel.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/14.
//

import Foundation


class WeatherViewModel {
    ///데이터가 완료 되었을 때 다시 업데이트 하기 위한 모델입니다.
    
    var weather: Weather?
    
    //헤더
    var cityString: String {
        return String(weather?.name ?? "")
    }
    var temperatureString: String {
        return String(format: "%.1f",(weather?.temp ?? 0).kelvinToCelsius) + "°C"
    }
    //푸터
    var feelsLikeString: String {
        return String(format: "%.1f",(weather?.feelsLike ?? 0).kelvinToCelsius) + "°C"
    }
    var minTemperatureString: String {
        return String(format: "%.1f",(weather?.tempMin ?? 0).kelvinToCelsius) + "°C"
    }
    var maxTemperatureString: String {
        return String(format: "%.1f",(weather?.tempMax ?? 0).kelvinToCelsius) + "°C"
    }
    var pressureString: String {
        return String(weather?.pressure ?? 0)
    }
    var humidityString: String {
        return String(weather?.humidity ?? 0)
    }
   
   
    
    
    func fetchWeather(for cityId: Int = 1835848, _ completion: @escaping (() -> Void)) {
        NetworkController.fetchWeather(for: cityId) { weather in
            self.weather = weather
            print(weather)
            completion()
        }
    }
    
}
