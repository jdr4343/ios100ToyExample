//
//  ViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/17.
//
//앱의 크기를 신경써서 만들어지지 않았습니다. 시뮬레이터를 아이폰 11로 변경해주세요.버튼이 아닌 단일 뷰로 보고싶으시다면 Main 스토리보드의 class를 변경하여 주세요.


import UIKit
import RAMAnimatedTabBarController

class ExampleListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        AnimatedTabBar()
        GradientView()
        DateFormatterView()
        AlarmView()
    }


    func AnimatedTabBar() {
        //버튼 추가 / 속성 추가
        let button = UIButton(frame: CGRect(x: 0, y: 35
                                             ,width: 130, height: 50))
        view.addSubview(button)
        button.backgroundColor = .systemPink
        button.setTitle("애니메이션 탭바", for: .normal)
        button.addTarget(self, action: #selector(didTabAnimatedButton), for: .touchUpInside)
    }
    func GradientView() {
        let button = UIButton(frame: CGRect(x: 130, y: 35,
                                            width: 100, height: 50))
        view.addSubview(button)
        button.backgroundColor = .systemIndigo
        button.setTitle("그라데이션", for: .normal)
        button.addTarget(self, action: #selector(didTabGradientButton), for: .touchUpInside)
    }
    func DateFormatterView() {
        let button = UIButton(frame: CGRect(x: 230, y: 35
                                             ,width: 80, height: 50))
        view.addSubview(button)
        button.backgroundColor = .systemRed
        button.setTitle("날짜 생성", for: .normal)
        button.addTarget(self, action: #selector(didTabDateFormatterButton), for: .touchUpInside)
    }
    func AlarmView() {
        let button = UIButton(frame: CGRect(x: 310, y: 35
                                             ,width: 50, height: 50))
        view.addSubview(button)
        button.backgroundColor = .systemBlue
        button.setTitle("알람", for: .normal)
        button.addTarget(self, action: #selector(didTabAlarmButton), for: .touchUpInside)
    }
    
    
    
    
    
    
    
    //action에 들어갈 기능구현 / 우리가 만들었던 CustomTabBarController를 불러올것 입니다! / 뷰전환
    @objc func didTabAnimatedButton() {
        let tabBarVC = AnimatedCustomTabBarController()
        present(tabBarVC, animated: true, completion: nil)
    }
    @objc func didTabGradientButton() {
        let gradientVC = GradientViewController()
        present(gradientVC, animated: true, completion: nil)
    }
    @objc func didTabDateFormatterButton() {
        let dateFormatterVC = DateFormatterViewController()
        present(dateFormatterVC, animated: true, completion: nil)
    }
    //스토리 보드를 통해서 뷰전환
    @objc func didTabAlarmButton() {
        if let AlarmVc = self.storyboard?.instantiateViewController(withIdentifier: "AlarmVC") {
            AlarmVc.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
            self.present(AlarmVc, animated: true)
        }
    }
}

