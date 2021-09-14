//
//  HomeWidzetTableViewCell.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/14.
//

import UIKit

class HomeWidzetTableViewCell: UITableViewCell {

    static let identifier = "HomeWidzetTableViewCell"
    private var currentWeather: CurrentWeather!
    // 날씨 뷰
    private let weatherView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "초록배경")
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 60
        return view
    }()
    private let weatherImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: <#T##String#>)
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        return view
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Sep 15, 2021"
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
        view.image = UIImage(named: "블루배경")
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 60
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(todoView)
        contentView.addSubview(weatherView)
        
        
        //날씨 위젯
        currentWeather = CurrentWeather()
        currentWeather.downloadCurrentWeather {
            print("데이터 다운로드")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        todoView.frame = CGRect(x: 10, y: 10, width: contentView.width/2-20, height: contentView.height-20)
        weatherView.frame = CGRect(x: todoView.right+15, y: 10, width: contentView.width/2-20, height: contentView.height-20)
        
    }
   
}
