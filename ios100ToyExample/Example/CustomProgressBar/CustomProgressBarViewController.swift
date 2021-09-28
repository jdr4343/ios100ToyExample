//
//  CustomProgressBarViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/27.
//

import UIKit

class CustomProgressBarViewController: UIViewController {
    
    private let shapeLayer = CAShapeLayer()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "  0%  "
        label.textColor = .label
        label.font = .systemFont(ofSize: 30, weight: .light)
       return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        label.sizeToFit()
        view.addSubview(label)
        label.center = view.center
        let center = view.center
        //원을 그립니다.
        let circulerPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -CGFloat.pi/2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        //트랙을 만듭니다.
        let trackLayer = CAShapeLayer()
        
        trackLayer.path = circulerPath.cgPath
        
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 10
        //배경
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = CAShapeLayerLineCap.round
        view.layer.addSublayer(trackLayer)
        
        
        //원을 그립니다.
        shapeLayer.path = circulerPath.cgPath
        
        shapeLayer.strokeColor = UIColor.yellow.cgColor
        shapeLayer.lineWidth = 10
        //배경
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        
        shapeLayer.strokeEnd = 0
        
        view.layer.addSublayer(shapeLayer)
        
        //뷰에 제스처 추가
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    @objc private func handleTap() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation.toValue = 1
        //지속 시간
        basicAnimation.duration = 100
        for x in 0..<100 {
            DispatchQueue.main.asyncAfter(deadline: .now()+(Double(x)*1.0),execute: {
                self.label.text = "\(x)%"
                
            })
        }
        //애니 메이션 종류휴 전체 획 제거 false
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
    }


}
