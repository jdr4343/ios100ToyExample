//
//  UsingTimerViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/22.
//

import UIKit

class UsingTimerViewController: UIViewController {
    
    //컬러 배열 생성
    let colors: [UIColor] = [
        .black,
        .orange,
        .brown,
        .yellow,
        .systemRed,
        .systemTeal,
        .systemYellow
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    //뷰가 화면에 표시된 이후 수행합니다. 뷰를 보여줄때 추가적인 작업을 담당합니다! 👛
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        createTimer()
    }
    
    

    //기본적인 타이머를 생성하고 2초의 타임 인터벌을 주겠습니다. 반복을 추가해 무한히 반복하도록 하겠습니다.
    private func createTimer() {
         let timer = Timer.scheduledTimer(
            timeInterval: 2,
            target: self,
            selector: #selector(fireTimer),
            userInfo: nil,
            repeats: true
        )
       
    }
    
    
    @objc private func fireTimer() {
        view.backgroundColor = colors.randomElement()
    }
}
