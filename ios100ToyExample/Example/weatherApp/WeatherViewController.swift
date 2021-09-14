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
    
    @IBOutlet weak var feelsLikeLabel: UILabel!
    
    @IBOutlet weak var minTemparatureLabel: UILabel!
    
    @IBOutlet weak var maxTemparatureLabel: UILabel!
    
    @IBOutlet weak var pressureLabel: UILabel!
    
    @IBOutlet weak var humidityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchWeather { [weak self] in
            DispatchQueue.main.async {
                self?.setUpHeader()
                self?.setUpSubHeader()
            }
          
        }
    }
    
    
    
    private func setUpHeader() {
        temperatureLabel.text = viewModel.temperatureString
        cityLabel.text = viewModel.cityString
    }
    
    private func setUpSubHeader() {
        feelsLikeLabel.text = viewModel.feelsLikeString
        minTemparatureLabel.text = viewModel.minTemperatureString
        maxTemparatureLabel.text = viewModel.maxTemperatureString
        pressureLabel.text = viewModel.pressureString
        humidityLabel.text = viewModel.humidityString
        
    }
    
}




