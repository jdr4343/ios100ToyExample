//
//  ViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/17.
//
//앱의 크기를 신경써서 만들어지지 않았습니다. 시뮬레이터를 아이폰 11로 변경해주세요.버튼이 아닌 단일 뷰로 보고싶으시다면 Main 스토리보드의 class를 변경하여 주세요.
//가르치고자 함이 아닌 같이 배우자는 취지로 만들었습니다. 참고로 저는 배운지 2개월 됬습니다.틀린 부분이 있을수 있으며 있을경우 댓글을 남겨주시면 다시 배우겠습니다!


import UIKit
import RAMAnimatedTabBarController
import Floaty

class ExampleListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        animatedTabBar()
        gradientView()
        dateFormatterView()
        alarmView()
        floatingButton()
        checkView()
        colorWellView()
        FontPickerView()
        CustomTabBarView()
        pdfKitView()
    }
//플로팅 버튼 구현
    func floatingButton() {
        let floating = Floaty()
        floating.addItem("플로팅 리스트", icon: UIImage(systemName: "plus")!, handler: { item in
            //핸들러를 열고 기능 구현을 하면 됩니다.
            
        })
        self.view.addSubview(floating)
    }

    //버튼 추가 / 속성 추가
    func animatedTabBar() {
        let button = UIButton(frame: CGRect(x: 0, y: 35
                                             ,width: 130, height: 50))
        view.addSubview(button)
        button.backgroundColor = .systemPink
        button.setTitle("애니메이션 탭바", for: .normal)
        button.addTarget(self, action: #selector(didTabAnimatedButton), for: .touchUpInside)
    }
    func gradientView() {
        let button = UIButton(frame: CGRect(x: 130, y: 35,
                                            width: 100, height: 50))
        view.addSubview(button)
        button.backgroundColor = .systemIndigo
        button.setTitle("그라데이션", for: .normal)
        button.addTarget(self, action: #selector(didTabGradientButton), for: .touchUpInside)
    }
    func dateFormatterView() {
        let button = UIButton(frame: CGRect(x: 230, y: 35
                                             ,width: 80, height: 50))
        view.addSubview(button)
        button.backgroundColor = .systemRed
        button.setTitle("날짜 생성", for: .normal)
        button.addTarget(self, action: #selector(didTabDateFormatterButton), for: .touchUpInside)
    }
    func checkView() {
        let button = UIButton(frame: CGRect(x: 310, y: 35
                                             ,width: 50, height: 50))
        view.addSubview(button)
        button.backgroundColor = .systemTeal
        button.setTitle("체크", for: .normal)
        button.addTarget(self, action: #selector(didTabCheckButton), for: .touchUpInside)
    }
    func alarmView() {
        let button = UIButton(frame: CGRect(x: 360, y: 35
                                             ,width: 55, height: 50))
        view.addSubview(button)
        button.backgroundColor = .systemBlue
        button.setTitle("알람", for: .normal)
        button.addTarget(self, action: #selector(didTabAlarmButton), for: .touchUpInside)
    }
    func colorWellView() {
        let button = UIButton(frame: CGRect(x: 0, y: 85
                                             ,width: 90, height: 50))
        view.addSubview(button)
        button.backgroundColor = .systemGray
        button.setTitle("색상 선택기", for: .normal)
        button.addTarget(self, action: #selector(didTabColorWellButton), for: .touchUpInside)
    }
    func FontPickerView() {
        let button = UIButton(frame: CGRect(x: 90, y: 85
                                             ,width: 90, height: 50))
        view.addSubview(button)
        button.backgroundColor = .systemFill
        button.setTitle("폰트 선택기", for: .normal)
        button.addTarget(self, action: #selector(didTabFontPickerButton), for: .touchUpInside)
    }
    func CustomTabBarView() {
        let button = UIButton(frame: CGRect(x: 180, y: 85
                                             ,width: 90, height: 50))
        view.addSubview(button)
        button.backgroundColor = .systemGreen
        button.setTitle("커스텀 탭바", for: .normal)
        button.addTarget(self, action: #selector(didTabCustomTabBarButton), for: .touchUpInside)
    }
    func pdfKitView() {
        let button = UIButton(frame: CGRect(x: 270, y: 85
                                             ,width: 90, height: 50))
        view.addSubview(button)
        button.backgroundColor = .systemYellow
        button.setTitle("PDF 삽입", for: .normal)
        button.addTarget(self, action: #selector(didTabPDFButton), for: .touchUpInside)
    }
    
    
    
    
    //action에 들어갈 기능구현 /  뷰전환은 여기에서 배우시면 될거 같습니다. 
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
    @objc func didTabCheckButton() {
        let CheckVC = CheckViewController()
        present(CheckVC, animated: true, completion: nil)
    }
    //스토리 보드를 통해서 뷰전환 / 각각의 스타일 들을 만들어 놓았으니 시뮬레이터를 플레이 해보시면서 어떤 차이점이 있는지 찾아보시면 도움이 될거 같습니다.
    @objc func didTabAlarmButton() {
        if let AlarmVc = self.storyboard?.instantiateViewController(withIdentifier: "AlarmVC") {
            AlarmVc.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
            self.present(AlarmVc, animated: true)
        }
    }
    @objc func didTabColorWellButton() {
        let ColorWellVC = ColorWellViewController()
        ColorWellVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        present(ColorWellVC, animated: true, completion: nil)
    }
    @objc func didTabFontPickerButton() {
        let FontPickerVC = FontPickerViewController()
        FontPickerVC.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        present(FontPickerVC, animated: true, completion: nil)
    }
    @objc func didTabCustomTabBarButton() {
        if let CustomTabBarVc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") {
            self.present(CustomTabBarVc, animated: true)
        }
    }
    @objc func didTabPDFButton() {
        if let pdfkitVC = self.storyboard?.instantiateViewController(withIdentifier: "PDFkitVC") {
        self.present(pdfkitVC, animated: true, completion: nil)
        }
    }
   
}

