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
    
    private let viewModel = WeatherViewModel()
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var cityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchWeather { [weak self] in
            DispatchQueue.main.async {
                self?.configureUI()
            }
          
        }
    }
    
    private func configureUI() {
        temperatureLabel.text = viewModel.temperatureString
        cityLabel.text = viewModel.cityString
    }
    
    
}




