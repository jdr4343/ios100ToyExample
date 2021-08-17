//
//  ColorWallViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/17.
//

import UIKit

class ColorWellViewController: UIViewController {

    let colorWell: UIColorWell = {
       let colorWell = UIColorWell()
        //사용자가 불투명도 지정할수 있도록 알파값을 전달해줍니다.
        colorWell.supportsAlpha = true
        //현재 선택된 컬러를 가져오도록 속성을 추가 해줍니다. /디폴트 값으로는 회색을 전달하겠습니다.
        colorWell.selectedColor = .systemGray
        colorWell.title = "색상 선택기"
        return colorWell
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //색상 선택기가 선택한 색깔로 백그라운드 컬러를 지정 하겠습니다!
        view.backgroundColor = colorWell.selectedColor
        view.addSubview(colorWell)
        colorWell.addTarget(self, action: #selector(colorChanged), for: .valueChanged)
    }
    
    override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            colorWell.frame = CGRect(x: 20,
                                     y: 35,
                                     width: view.frame.size.width-40,
                                     height: 50)
    }
    @objc private func colorChanged() {
        view.backgroundColor = colorWell.selectedColor
    }


}
