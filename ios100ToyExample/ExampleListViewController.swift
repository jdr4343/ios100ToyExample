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
        title = "100가지 예제"
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
        spinnerView()
        webView()
        barButtonItemView()
    }
    //플로팅 버튼 구현
    func floatingButton() {
        let floating = Floaty()
        floating.addItem("수평 슬라이드 컬렉션 테이블뷰", icon: UIImage(systemName: "slider.horizontal.below.square.fill.and.square")!, handler: { item in
            //핸들러를 열고 기능 구현을 하면 됩니다.
            let CarouselVC = CarouselViewController()
            self.present(CarouselVC, animated: true, completion: nil)
        })
        floating.addItem("동영상,수평,수직 컬렉션 테이블뷰", icon: UIImage(systemName: "square.grid.3x1.fill.below.line.grid.1x2")!, handler: { item in
            let AdvancedVC = AdvancedViewController()
            self.present(AdvancedVC, animated: true, completion: nil)
        })
        self.view.addSubview(floating)
    }

    //버튼 추가 / 속성 추가
    func animatedTabBar() {
        let button = UIButton(frame: CGRect(x: 0, y: 90
                                             ,width: 130, height: 50))
        view.addSubview(button)
        button.backgroundColor = .systemPink
        button.setTitle("애니메이션 탭바", for: .normal)
        button.addTarget(self, action: #selector(didTabAnimatedButton), for: .touchUpInside)
    }
    func gradientView() {
        let button = UIButton(frame: CGRect(x: 130, y: 90,
                                            width: 100, height: 50))
        view.addSubview(button)
        button.backgroundColor = .systemIndigo
        button.setTitle("그라데이션", for: .normal)
        button.addTarget(self, action: #selector(didTabGradientButton), for: .touchUpInside)
    }
    func dateFormatterView() {
        let button = UIButton(frame: CGRect(x: 230, y: 90
                                             ,width: 80, height: 50))
        view.addSubview(button)
        button.backgroundColor = .systemRed
        button.setTitle("날짜 생성", for: .normal)
        button.addTarget(self, action: #selector(didTabDateFormatterButton), for: .touchUpInside)
    }
    func checkView() {
        let button = UIButton(frame: CGRect(x: 310, y: 90
                                             ,width: 50, height: 50))
        view.addSubview(button)
        button.backgroundColor = .systemTeal
        button.setTitle("체크", for: .normal)
        button.addTarget(self, action: #selector(didTabCheckButton), for: .touchUpInside)
    }
    func alarmView() {
        let button = UIButton(frame: CGRect(x: 360, y: 90
                                             ,width: 55, height: 50))
        view.addSubview(button)
        button.backgroundColor = .systemBlue
        button.setTitle("알람", for: .normal)
        button.addTarget(self, action: #selector(didTabAlarmButton), for: .touchUpInside)
    }
    func colorWellView() {
        let button = UIButton(frame: CGRect(x: 0, y: 140
                                             ,width: 90, height: 50))
        view.addSubview(button)
        button.backgroundColor = .systemGray
        button.setTitle("색상 선택기", for: .normal)
        button.addTarget(self, action: #selector(didTabColorWellButton), for: .touchUpInside)
    }
    func FontPickerView() {
        let button = UIButton(frame: CGRect(x: 90, y: 140
                                             ,width: 90, height: 50))
        view.addSubview(button)
        button.backgroundColor = .systemFill
        button.setTitle("폰트 선택기", for: .normal)
        button.addTarget(self, action: #selector(didTabFontPickerButton), for: .touchUpInside)
    }
    func CustomTabBarView() {
        let button = UIButton(frame: CGRect(x: 180, y: 140
                                             ,width: 90, height: 50))
        view.addSubview(button)
        button.backgroundColor = .systemGreen
        button.setTitle("커스텀 탭바", for: .normal)
        button.addTarget(self, action: #selector(didTabCustomTabBarButton), for: .touchUpInside)
    }
    func pdfKitView() {
        let button = UIButton(frame: CGRect(x: 270, y: 140
                                             ,width: 90, height: 50))
        view.addSubview(button)
        button.backgroundColor = .systemYellow
        button.setTitle("PDF 삽입", for: .normal)
        button.addTarget(self, action: #selector(didTabPDFButton), for: .touchUpInside)
    }
    func spinnerView() {
        let button = UIButton(frame: CGRect(x: 0, y: 190
                                             ,width: 90, height: 50))
        view.addSubview(button)
        button.backgroundColor = .systemPurple
        button.setTitle("스피너 버튼", for: .normal)
        button.addTarget(self, action: #selector(didTabSpinnerButton), for: .touchUpInside)
    }
    func webView() {
        let button = UIButton(frame: CGRect(x: 360, y: 140
                                             ,width: 55, height: 50))
        view.addSubview(button)
        button.backgroundColor = .systemOrange
        button.setTitle("웹뷰", for: .normal)
        button.addTarget(self, action: #selector(didTabWebButton), for: .touchUpInside)
    }
    func barButtonItemView() {
        let button = UIButton(frame: CGRect(x: 90, y: 190
                                             ,width: 60, height: 50))
        view.addSubview(button)
        button.backgroundColor = .brown
        button.setTitle("바 버튼", for: .normal)
        button.addTarget(self, action: #selector(didTabBarButtonItem), for: .touchUpInside)
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
        let checkVC = CheckViewController()
        present(checkVC, animated: true, completion: nil)
    }
    //스토리 보드를 통해서 뷰전환 / 각각의 스타일 들을 만들어 놓았으니 시뮬레이터를 플레이 해보시면서 어떤 차이점이 있는지 찾아보시면 도움이 될거 같습니다.
    @objc func didTabAlarmButton() {
        if let alarmVc = self.storyboard?.instantiateViewController(withIdentifier: "AlarmVC") {
            alarmVc.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
            self.present(alarmVc, animated: true)
        }
    }
    @objc func didTabColorWellButton() {
        let colorWellVC = ColorWellViewController()
        colorWellVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        present(colorWellVC, animated: true, completion: nil)
    }
    @objc func didTabFontPickerButton() {
        let fontPickerVC = FontPickerViewController()
        fontPickerVC.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        present(fontPickerVC, animated: true, completion: nil)
    }
    @objc func didTabCustomTabBarButton() {
        if let customTabBarVc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") {
            self.present(customTabBarVc, animated: true)
        }
    }
    @objc func didTabPDFButton() {
        if let pdfkitVC = self.storyboard?.instantiateViewController(withIdentifier: "PDFkitVC") {
        self.present(pdfkitVC, animated: true, completion: nil)
        }
    }
    @objc func didTabSpinnerButton() {
        let spinnerVC = SpinnerViewController()
        present(spinnerVC, animated: true, completion: nil)
    }
    @objc func didTabWebButton() {
        let webVC = WebViewController()
        present(webVC, animated: true, completion: nil)
    }
    //네비게이션을 통한 뷰 전환
    @objc func didTabBarButtonItem() {
        let barButtonItemlVC = BarButtonItemViewController()
        self.navigationController?.pushViewController(barButtonItemlVC, animated: true)
    }
   
}

