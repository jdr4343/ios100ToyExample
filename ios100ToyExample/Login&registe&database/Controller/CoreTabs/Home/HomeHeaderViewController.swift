//
//  HomeHeaderViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/12.
//

import UIKit

class HomeHeaderViewController: UIView {

    static let identifier = "HomeHeaderViewController"
    
    ///시간 추가 라벨 입니다
    let tenMinLabel: UILabel = {
        let label = UILabel()
        label.text = "10분"
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .center
       // label.target(forAction: <#T##Selector#>, withSender: <#T##Any?#>)
        return label
    }()
    let twentyMinLabel: UILabel = {
        let label = UILabel()
        label.text = "20분"
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .center
      //  label.target(forAction: <#T##Selector#>, withSender: <#T##Any?#>)
        return label
    }()
    let thirtyMinLabel: UILabel = {
        let label = UILabel()
        label.text = "30분"
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .center
       // label.target(forAction: <#T##Selector#>, withSender: <#T##Any?#>)
        return label
    }()
    let onehourLabel: UILabel = {
        let label = UILabel()
        label.text = "1시간"
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .center
       // label.target(forAction: <#T##Selector#>, withSender: <#T##Any?#>)
        return label
    }()
    let addFiveMinLabel: UILabel = {
        let label = UILabel()
        label.text = "+5분"
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        //label.target(forAction: <#T##Selector#>, withSender: <#T##Any?#>)
        return label
    }()
    
    ///타이머를 시작하고 멈추고 음악을 재생하거나 멈춥니다.
    let startStoputton: UIButton = {
        let button = UIButton()
       // button.target(forAction: <#T##Selector#>, withSender: <#T##Any?#>)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .brown
        addSubview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        thirtyMinLabel.frame = CGRect(x: width/2-25, y: safeAreaInsets.bottom+20, width: 50, height: 50)
        
        twentyMinLabel.frame = CGRect(x: thirtyMinLabel.left-75, y: safeAreaInsets.bottom+20, width: 50, height: 50)
        tenMinLabel.frame = CGRect(x: twentyMinLabel.left-75, y: safeAreaInsets.bottom+20, width: 50, height: 50)
        
        onehourLabel.frame = CGRect(x: thirtyMinLabel.right+25, y: safeAreaInsets.bottom+20, width: 50, height: 50)
        addFiveMinLabel.frame = CGRect(x: onehourLabel.right+25, y: safeAreaInsets.bottom+20, width: 50, height: 50)
//        startStoputton.frame = CGRect(x: <#T##CGFloat#>, y: <#T##CGFloat#>, width: <#T##CGFloat#>, height: <#T##CGFloat#>)
    }

     func addSubview() {
        addSubview(tenMinLabel)
        addSubview(twentyMinLabel)
        addSubview(thirtyMinLabel)
        addSubview(onehourLabel)
        addSubview(addFiveMinLabel)
        addSubview(startStoputton)
    }
    
    
}
