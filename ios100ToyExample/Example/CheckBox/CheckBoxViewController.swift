//
//  CheckBoxViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/16.
//

import UIKit

class CheckBoxViewController: UIViewController {

    let checkbox1 = CircleCheckBox(frame: CGRect(x: 70, y: 200, width: 40, height: 40))
    let checkbox2 = SquareCheckBox(frame: CGRect(x: 70, y: 300, width: 40, height: 40))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        //뷰 추가
        let label = UILabel(frame: CGRect(x: 115, y: 200, width: 200, height: 40))
        label.text = "동그라미 체크 버튼 ⃝!"
        view.addSubview(label)
        view.addSubview(checkbox1)
        //체크 박스에 제스쳐를 연결 합니다.
        let geseture = UITapGestureRecognizer(target: self, action: #selector(didTapCheckBox1))
        checkbox1.addGestureRecognizer(geseture)
        
        //뷰 추가
        let label2 = UILabel(frame: CGRect(x: 115, y: 300, width: 200, height: 40))
        label2.text = "네모 체크 버튼▢!"
        view.addSubview(label2)
        view.addSubview(checkbox2)
        //체크 박스에 제스쳐를 연결 합니다.
        let geseture2 = UITapGestureRecognizer(target: self, action: #selector(didTapCheckBox2))
        checkbox2.addGestureRecognizer(geseture2)

      
    }
    @objc func didTapCheckBox1() {
        checkbox1.toggle()
    }

    @objc func didTapCheckBox2() {
        checkbox2.toggle()
    }
  

}
