//
//  ChaneBackViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/27.
//

import UIKit

class ChangeBackViewController: UIViewController {

    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .brown
        button.setTitle("첫번쩨 뷰에 알람을 보내겠습니다.", for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(button)
     
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        button.center = view.center
    }
       
    
    @objc private func didTapButton() {
        NotificationCenter.default.post(name: Notification.Name("색깔을 바꾸어라!"),object: nil)
    }


    

}
