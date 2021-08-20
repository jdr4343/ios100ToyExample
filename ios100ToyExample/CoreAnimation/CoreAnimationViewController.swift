//
//  CoreAnimationViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/20.
//

import UIKit

class CoreAnimationViewController: UIViewController {

    private let layer: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor.systemGreen.cgColor
        layer.frame = CGRect(x: 100, y: 100, width: 120, height: 120)
        
        return layer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.addSublayer(layer)
        //스피너에서 그랬던 것처럼 지연 시키겠습니다.
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.animateMovement()
            self.animateOpacity()
        }
        
    }
    func animateMovement() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.fromValue = CGPoint(x: layer.frame.origin.x + (layer.frame.size.width/2),
                                      y: layer.frame.origin.x + (layer.frame.size.height/2))
        animation.toValue = CGPoint(x: 300,
                                    y: 400)
        animation.duration = 1 //애니메이션 지속 시간
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        animation.beginTime = CACurrentMediaTime()
        layer.add(animation, forKey: nil)
    }
    func animateOpacity() {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 1
        animation.toValue = 0
        animation.duration = 2 //애니메이션 지속 시간
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        animation.beginTime = CACurrentMediaTime()
        layer.add(animation, forKey: nil)
    }


}
