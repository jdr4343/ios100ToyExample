//
//  WeatherViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/14.
//

import UIKit
//https://openweathermap.org/current
///날씨API를 통해 기본적인 날씨 앱을 만들겠습니다.
class WeatherViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkController.fetchWeather { weather in
            print("날씨 API :\(weather)")
        }

      
    }



}
