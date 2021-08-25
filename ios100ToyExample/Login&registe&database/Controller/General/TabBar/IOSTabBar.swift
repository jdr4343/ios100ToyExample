//
//  IOSTabBar.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/25.
//

import UIKit

class IOSTabBar: UITabBar {

    private var shapeLayer: CALayer?
           
           private func addShape() {
               let shapeLayer = CAShapeLayer()
               shapeLayer.path = creatPath()
               shapeLayer.strokeColor = UIColor.clear.cgColor
               shapeLayer.fillColor = UIColor(named: "RG")?.cgColor
               shapeLayer.lineWidth = 1.0
               
               shapeLayer.shadowOffset = CGSize(width: 0, height: 0)
               shapeLayer.shadowRadius = 10
               shapeLayer.shadowColor = UIColor.black.cgColor
               shapeLayer.shadowOpacity = 0.3
               
               if let oldShapeLayer = self.shapeLayer {
                   self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
               } else {
                self.layer.insertSublayer(shapeLayer, at: 0)
               }
            self.shapeLayer = shapeLayer
           }
    
    override func draw(_ rect: CGRect) {
        self.addShape()
        self.unselectedItemTintColor = UIColor.darkGray
        self.tintColor = UIColor.black
    }
    
    func creatPath() -> CGPath {
        let height: CGFloat = 86.0
               let path = UIBezierPath()
               let centerWidth = self.frame.width / 2
               path.move(to: CGPoint(x: 0, y: 0))
               path.addLine(to: CGPoint(x: (centerWidth - height ), y: 0))
               path.addCurve(to: CGPoint(x: centerWidth, y: height - 40),
                             controlPoint1: CGPoint(x: (centerWidth - 30), y: 0), controlPoint2: CGPoint(x: centerWidth - 35, y: height - 40))
               path.addCurve(to: CGPoint(x: (centerWidth + height ), y: 0),
                             controlPoint1: CGPoint(x: centerWidth + 35, y: height - 40), controlPoint2: CGPoint(x: (centerWidth + 30), y: 0))
               path.addLine(to: CGPoint(x: self.frame.width, y: 0))
               path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
               path.addLine(to: CGPoint(x: 0, y: self.frame.height))
               path.close()
        
        return path.cgPath
           }

}
