//
//  CustomTabBarController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/17.
//
import RAMAnimatedTabBarController
import UIKit

class AnimatedCustomTabBarController: RAMAnimatedTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //탭바 항목
        configure()

        
    }
    
    func configure() {
        //탭바의 기능 구현을 위해 4개의 뷰 컨트롤러 생성
        let vc1 = UIViewController()
        let vc2 = UIViewController()
        let vc3 = UIViewController()
        let vc4 = UIViewController()
        //각탭당 배경색
        vc1.view.backgroundColor = .white
        vc2.view.backgroundColor = .purple
        vc3.view.backgroundColor = .yellow
        vc4.view.backgroundColor = .systemPink
        //각각의 탭바 항목을 지정
        vc1.tabBarItem = RAMAnimatedTabBarItem(title: "음",
                                               image: UIImage(systemName: "house"),
                                               tag: 1)
        vc2.tabBarItem = RAMAnimatedTabBarItem(title: "아침",
                                               image: UIImage(systemName: "gear"),
                                               tag: 1)
        vc3.tabBarItem = RAMAnimatedTabBarItem(title: "시간대라",
                                               image: UIImage(systemName: "bell"),
                                               tag: 1)
        vc4.tabBarItem = RAMAnimatedTabBarItem(title: "배기 고ㅍㅏ..",
                                               image: UIImage(systemName: "airplane"),
                                               tag: 1)
        //애니메이션 추가 / 다운캐스팅 as!? 하위 클래스의 인스턴스를 참조하기 위해 사용
        (vc1.tabBarItem as? RAMAnimatedTabBarItem)?.animation = RAMBounceAnimation()
        (vc2.tabBarItem as? RAMAnimatedTabBarItem)?.animation = RAMFumeAnimation()
        (vc3.tabBarItem as? RAMAnimatedTabBarItem)?.animation = RAMFlipTopTransitionItemAnimations()
        (vc4.tabBarItem as? RAMAnimatedTabBarItem)?.animation = RAMRightRotationAnimation()
        
        //새로 생성된 4개의 컨트롤러 전달
        setViewControllers([vc1, vc2, vc3, vc4], animated: false)
    }
    


}
