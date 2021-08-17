//
//  GradientViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/17.
//

import UIKit

class GradientViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       gradientsView()
        
    }
    //그라디언트 생성
    func gradientsView() {
        let gradientsLayer = CAGradientLayer()
        gradientsLayer.frame = view.bounds
        gradientsLayer.colors = [
            UIColor.white.cgColor,
            UIColor.systemIndigo.cgColor,
            UIColor.systemPink.cgColor
        ]
        view.layer.addSublayer(gradientsLayer)
    }

}
