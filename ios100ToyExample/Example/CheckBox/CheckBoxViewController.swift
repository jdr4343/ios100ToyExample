//
//  CheckBoxViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/16.
//

import UIKit

class CheckBoxViewController: UIViewController {

    let checkbox1 = CircleCheckBox(frame: CGRect(x: 70, y: 200, width: 40, height: 40))
    
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

      
    }
    @objc func didTapCheckBox1() {
        checkbox1.toggle()
    }

  

}
