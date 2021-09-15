//
//  HomeWidzetTableViewCell.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/14.
//

import UIKit

class HomeWidzetTableViewCell: UITableViewCell {

    static let identifier = "HomeWidzetTableViewCell"
    private var currentWeather: CurrentWeather?
    // 날씨 뷰
    private let weatherView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "배경3")
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 60
        return view
    }()
    private let weatherImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "sun.min.fill")
        view.tintColor = .white
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        return view
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Sep 15, 20214"
        label.font = .boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "19.5°C"
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.text = "Seoul"
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    private let weatherLabel: UILabel = {
        let label = UILabel()
        label.text = "비"
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    
    
    //To Do 뷰
    let todoView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "배경2")
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 60
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(todoView)
        addWeatherView()
        
        
        //날씨 위젯
        currentWeather = CurrentWeather()
        currentWeather?.downloadCurrentWeather {
            self.updateWeaderUI()
            print("데이터 다운로드")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        todoView.frame = CGRect(x: 10, y: 10, width: contentView.width/2-20, height: contentView.height-20)
        //날씨
        weatherView.frame = CGRect(x: todoView.right+15, y: 10, width: contentView.width/2-20, height: contentView.height-20)
        dateLabel.frame = CGRect(x: 10, y: 10, width: weatherView.width-20, height: 20)
        cityLabel.frame = CGRect(x: 10, y: dateLabel.bottom+10, width: weatherView.width-20, height: 20)
        temperatureLabel.frame = CGRect(x: 10, y: cityLabel.bottom+10, width: weatherView.width-20, height: 40)
        weatherImageView.frame = CGRect(x: weatherView.width/2-25, y: temperatureLabel.bottom, width: 50, height: 50)
        weatherLabel.frame = CGRect(x: 10, y: weatherImageView.bottom+30, width: weatherView.width-20, height: 20)
    }
   
    private func addWeatherView() {
        //뷰
        contentView.addSubview(weatherView)
        weatherView.addSubview(weatherImageView)
        //라벨
        weatherView.addSubview(dateLabel)
        weatherView.addSubview(temperatureLabel)
        weatherView.addSubview(weatherLabel)
        weatherView.addSubview(cityLabel)
       
    }
    private func updateWeaderUI() {
        
        cityLabel.text = currentWeather?.cityName
        temperatureLabel.text = "\(Int(currentWeather?.currentTemp ?? 0.0))°C"
        weatherLabel.text = currentWeather?.weatherType
        dateLabel.text = currentWeather?.date
        
    }
    
    
}
