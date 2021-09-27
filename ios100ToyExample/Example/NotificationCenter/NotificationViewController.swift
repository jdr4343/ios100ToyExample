//
//  NotificationViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/27.
//

import UIKit

class NotificationViewController: UIViewController {

    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .brown
        button.setTitle("두번쨰뷰에서 알람을 받을것입니다.", for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        view.addSubview(button)
     
        ///두번쨰 뷰에서 색깔을 바꾸라는 알람을 듣고 뷰는 액션을 수행합니다.
        NotificationCenter.default.addObserver(self, selector: #selector(ChangeBackGroundColor), name: NSNotification.Name("색깔을 바꾸어라!"), object: nil)
    }
    
    ///두번쨰 뷰에서 버튼을 누르면 첫번째 뷰에서 관찰자가 알람을 확인하고 색깔을 바꿉니다.
    @objc private func ChangeBackGroundColor() {
        view.backgroundColor = .systemTeal
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        button.center = view.center
    }

    @objc private func didTapButton() {
        let vc = ChangeBackViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

  

}
