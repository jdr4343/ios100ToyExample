//
//  BarButtonItemViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/18.
//

import UIKit

class BarButtonItemViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        title = "BarButton"
        
       //네비게이션 바 색상 변환
        navigationController?.navigationBar.tintColor = .label
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        view.addSubview(button)
        button.center = view.center
        button.backgroundColor = .systemYellow
        button.setTitle("두번째 뷰로가기", for: .normal)
        button.addTarget(self, action: #selector(didTapbutton), for: .touchUpInside)
        
        configureItem()
    }
    
    //바 아이템 생성
    private func configureItem() {
        //시스템 아이템으로 생성 / Item 뒤에 s가 붙습니다.. 여러개 같이 추가하려면 한참을 찾았네유 ㅠㅠ 계속 에러가 떠가지고 참,..
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(
                barButtonSystemItem: .add,
                target: self,
                action: nil),
            //이미지로 생성 SF symbols를 아시나요? 애플에서 무료료 제공하는 이미지들 입니다! 얼른 다운 받으세요!
            UIBarButtonItem(
                image: UIImage(systemName: "gear"),
                style: .done,
                target: self,
                action: nil)
        ]
        
    }
    //네비게이션 방식으로 뷰 연결 / 뷰를 전환하고 나면 우리가 이전 뷰에서 만들어 놓은 버튼은 사라지게 됩니다. 새로운 버튼을 추가 하겠습니다
    @objc func didTapbutton() {
        let vc = UIViewController()
        vc.title = "두번째 뷰"
        vc.view.backgroundColor = .systemGreen
        //글로 생성
        vc.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "어디갔어 add!", style: .done, target: self, action: nil)
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
        
    
}
