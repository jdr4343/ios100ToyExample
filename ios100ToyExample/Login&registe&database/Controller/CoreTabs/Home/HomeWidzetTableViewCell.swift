//
//  HomeWidzetTableViewCell.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/14.
//

import UIKit

class HomeWidzetTableViewCell: UITableViewCell {

    static let identifier = "HomeWidzetTableViewCell"
    
    let weatherView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "날씨배경")
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 60
        return view
    }()
    
    let todoView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "무슨배경")
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 60
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(todoView)
        contentView.addSubview(weatherView)
        weatherViewConfiguer()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        todoView.frame = CGRect(x: 10, y: 10, width: contentView.width/2-20, height: contentView.height-20)
        weatherView.frame = CGRect(x: todoView.right+15, y: 10, width: contentView.width/2-20, height: contentView.height-20)
        
    }
    func weatherViewConfiguer() {
        let weather = weatherView
        
        
    }
}
