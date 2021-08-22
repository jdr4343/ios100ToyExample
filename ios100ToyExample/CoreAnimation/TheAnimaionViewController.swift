//
//  TheAnimaionViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/20.
//

import UIKit
import TheAnimation
//애니메이션을 좀더 쉽게 해주는 프레임 워크입니다. 애니메이션에 관심 있으신분은 한번 찾아보시길 바랍니다.
//아래의 코드는 우리가 만들었던 CoreAnimationViewContller와 동일한 작동을합니다.
//그러나 많은 부분이 메서드화 되어 있기때문에 좀더 편하다는거 같습니다.

class TheAnimaionViewController: UIViewController {

        private let layer: CALayer = {
            let layer = CALayer()
            layer.backgroundColor = UIColor.systemGreen.cgColor
            layer.frame = CGRect(x: 100, y: 100, width: 120, height: 120)
            
            return layer
        }()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            title = "애니메이션 프레임워크"
            view.layer.addSublayer(layer)
            //스피너에서 그랬던 것처럼 지연 시키겠습니다.
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.animateMovement()
                self.animateOpacity()
            }
            
        }
        func animateMovement() {
            let animation = BasicAnimation(keyPath: .position)
            animation.fromValue = CGPoint(x: layer.frame.origin.x + (layer.frame.size.width/2),
                                          y: layer.frame.origin.x + (layer.frame.size.height/2))
            animation.toValue = CGPoint(x: 300,
                                        y: 400)
            animation.duration = 1 //애니메이션 지속 시간
            animation.timingFunction = .easeInEaseOut
            animation.fillMode = .forwards
            animation.isRemovedOnCompletion = false
            animation.beginTime = CACurrentMediaTime()
            animation.animate(in: layer)
        }
        func animateOpacity() {
            let animation = BasicAnimation(keyPath: .opacity)
            animation.fromValue = 1
            animation.toValue = 0
            animation.duration = 2 //애니메이션 지속 시간
            animation.fillMode = .forwards
            animation.isRemovedOnCompletion = false
            animation.beginTime = CACurrentMediaTime()
            animation.animate(in: layer)
        }


    }
