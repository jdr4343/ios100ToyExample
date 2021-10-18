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
//        .black,
//        .orange,
//        .brown,
//        .yellow,
//        .systemRed,
//        .systemTeal,
//        .systemYellow
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    //뷰가 화면에 표시된 이후 수행합니다. 뷰를 보여줄때 추가적인 작업을 담당합니다! 👛
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //createTimer()
        createTimer2()
        createTimer3()
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
        timer.tolerance = 200
    }
    
 
    @objc private func fireTimer() {
        view.backgroundColor = colors.randomElement()
    }
    
    
    //위의 동일한 코드를 한 함수에서 만들수도 있습니다. 아마 이러한 형식의 코드는 더욱더 자주 보게 될 것입니다. 핸들러를 이용하는 프레임워크도 매우 많거든요.그리고 처음에는 익숙지 않더라도 가드문 마냥 나중에는 더 편해집니다. 이 코드에서 타이머를 종료하는 시점을 정할수 있도록 ran 변수를 추가해주고 화면이 바뀔때마다 시간초를 추가해 지정 초가 되면 멈추도록 하겠습니다.
    private func createTimer2() {
     
        var ran = 1
        _ = Timer.scheduledTimer(withTimeInterval: 2,
                                 repeats: true
        ) { [weak self] timer in
            if ran >= 20 {
                timer.invalidate()
                print("20초가 지나 타이머가 멈춥니다.")
            }
            DispatchQueue.main.async {
                self?.view.backgroundColor = self?.colors.randomElement() ?? .clear
                ran += 1
            }
        }
    }
    //타이머를 이용해서 간단한 애니메이션 효과를 줘 보겠습니다.
    private func createTimer3() {
        var isAnimated = true
        let myView = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 200))
        view.addSubview(myView)
        myView.center = view.center
        myView.backgroundColor = .link
        var x = 0
        let timer = Timer.scheduledTimer(withTimeInterval: 2,
                                 repeats: true
        ) { [weak self] timer in
            //self의 옵셔널 값 랩핑
            guard let strongSelf = self else {
                return
            }
           
            ///300초 300 / 100 = 3 width 400 / 100 = 4
            DispatchQueue.main.async {
               
                if isAnimated {
                    UIView.animate(withDuration: 3) {
                        x += 4
                        myView.frame = CGRect(x: 0, y: 0, width: 400-x, height: 200)
                        print(x)
                      //  myView.center = strongSelf.view.center
                    }
//                    isAnimated = false
                }
//                else {
//                    UIView.animate(withDuration: 3) {
//                        myView.frame = CGRect(x: 0, y: 0, width: 400-x, height: 200)
//                       // myView.center = strongSelf.view.center
//                    }
//                    isAnimated = true
         //       }
            }
            
        }
        timer.fire()
    }
    
    
}
