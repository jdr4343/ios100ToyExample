//
//  DateFormatterViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/17.
//

import UIKit

class DateFormatterViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        dateFormatter()
    }
    
    
    func dateFormatter() {
        //UILabel 생성
        let label1 = UILabel(frame: CGRect(x: 0, y: 0, width: view.width, height: 50))
        label1.center = view.center
        label1.textAlignment = .center
        view.addSubview(label1)
      
        let label2 = UILabel(frame: CGRect(x: 0, y: label1.bottom+10, width: view.width, height: 50))
        label2.textAlignment = .center
        label2.textAlignment = .center
        view.addSubview(label2)
        
        let date = Date()
        
        let formatter1 = DateFormatter()
        formatter1.timeZone = .current
        formatter1.timeZone = .current
        formatter1.dateFormat = "MM/dd/yyyy"
        //꼭 날짜형식을 정해줘야 하는건 아닙니다.
        let formatter2 = DateFormatter()
        formatter2.timeZone = .current
        formatter2.timeZone = .current
        formatter2.dateStyle = .full
        
        
        label1.text = formatter1.string(from: date)
        label2.text = formatter2.string(from: date)
        
    }
    


}

    
