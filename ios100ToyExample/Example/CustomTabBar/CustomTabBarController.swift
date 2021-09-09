//
//  CustomTabBarController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/17.
//

import UIKit

//저번의 탭바에서는 코드를 이용해 뷰를 짰으니 이번 탭바에서는 스토리 보드를 이용하여 짜보겠습니다!
class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {
    //스토리 보드의 탭바뷰를 누르시고 오른쪽 상단의 4번째 아이콘을 누르신후 아래에 보면 class에 연결되어 있습니다.
    required init?(coder: NSCoder) {
           super.init(coder: coder)
       }
       
       override func viewDidLoad() {
           super.viewDidLoad()
           self.delegate = self
          selectedIndex = 1
           
           setupMiddleButton()
       }
       
       func setupMiddleButton() {
           //버튼 크기
           let middelButton = UIButton(frame: CGRect(x: (view.bounds.width/2)-25,
                                                     y: -20,
                                                     width: 60,
                                                     height: 60))
           //버튼 이미지삽입 / 테두리 그림자 설정
           middelButton.setBackgroundImage(UIImage(named: "home"), for: .normal)
           middelButton.layer.shadowColor = UIColor.black.cgColor
           middelButton.layer.shadowOpacity = 0.1
           middelButton.layer.shadowOffset = CGSize(width: 4, height: 4)
           //탭바 추가 / 액션 추가
           tabBar.addSubview(middelButton)
           middelButton.addTarget(self, action: #selector(menuButtonAction), for: .touchUpInside)
           
           view.layoutIfNeeded()
       }
       //액션 기능 생성
       @objc func menuButtonAction(sender: UIButton) {
           selectedIndex = 1
       }
   }


