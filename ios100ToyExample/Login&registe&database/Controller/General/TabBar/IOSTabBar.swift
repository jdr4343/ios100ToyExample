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
            shapeLayer.fillColor = UIColor.systemBackground.cgColor
               shapeLayer.lineWidth = 1.0
               
               shapeLayer.shadowOffset = CGSize(width: 0, height: 0)
               shapeLayer.shadowRadius = 10
               shapeLayer.shadowColor = UIColor(named: "DG")?.cgColor
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
               self.unselectedItemTintColor = UIColor.white
               //self.tintColor = UIColor(named: "DG")
           }
           
           func creatPath() -> CGPath {
               let height: CGFloat = 15
               let path = UIBezierPath()
               let centerWidth = self.frame.width/2
              
               path.move(to: CGPoint(x: 0, y: -20)) //start pos
               
               //왼쪽
               path.addLine(to: CGPoint(x: centerWidth - 50, y: 0))// 왼쪽 경사
               path.addQuadCurve(to: CGPoint(x: centerWidth - 30,y: 20), //왼쪽 위 곡선
                                 controlPoint: CGPoint(x: centerWidth - 30, y: 5))
               path.addLine(to: CGPoint(x: centerWidth - 29, y: height - 10))//왼쪽 수직선
               path.addQuadCurve(to: CGPoint(x: centerWidth, y: height + 10),//왼쪽 아래 곡선
                                 controlPoint: CGPoint(x: centerWidth - 30, y: height + 10))
               
               //오른쪽
               path.addQuadCurve(to: CGPoint(x: centerWidth + 40, y: height - 10),//오른쪽 아래 곡선
                                 controlPoint: CGPoint(x: centerWidth + 40, y: height + 10))
               path.addLine(to: CGPoint(x: centerWidth + 41, y: 20))//오른쪽 수직선
               path.addQuadCurve(to: CGPoint(x: centerWidth + 50, y: 0),//오른쪽 위 곡선
                                 controlPoint: CGPoint(x: centerWidth + 41, y: 5))
               path.addLine(to: CGPoint(x: self.frame.width, y: -20)) //오른쪽 경사
               
               //경로 해제
               path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
               path.addLine(to: CGPoint(x: 0, y: self.frame.height))
               path.close()
               
               return path.cgPath
           }

}
