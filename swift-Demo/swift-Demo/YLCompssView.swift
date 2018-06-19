//
//  YLCompssView.swift
//  Compass
//
//  Created by admin on 2018/6/19.
//  Copyright © 2018年 dai. All rights reserved.
//

import UIKit

class YLCompssView: UIView {
    
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setNeedsDisplay()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let currentContext = UIGraphicsGetCurrentContext() else {
            return
        }
        let perAngle = CGFloat.pi/180.0
        // 绘制最外层 框
        for i in 0..<10{
            let startAngle: CGFloat = 0.5 * perAngle + CGFloat(36 * perAngle * CGFloat(i)) - CGFloat(90 * perAngle)
            let endAngle: CGFloat = startAngle +  CGFloat(35 * perAngle)
            let bezPath = UIBezierPath.init(arcCenter: CGPoint.init(x: self.frame.size.width/2, y: self.frame.size.height/2), radius: self.frame.size.width/2 - 30, startAngle: startAngle, endAngle: endAngle, clockwise: true)

            let shapeLayer = CAShapeLayer()
            shapeLayer.strokeColor = UIColor.white.cgColor
            shapeLayer.lineWidth = 20
            shapeLayer.path = bezPath.cgPath
            shapeLayer.fillColor = UIColor.clear.cgColor
            self.layer.addSublayer(shapeLayer)
        }
        // 绘制中心十字
        currentContext.setStrokeColor(UIColor.white.cgColor)
        currentContext.setLineWidth(1.0)
        currentContext.setLineCap(CGLineCap.square)
        currentContext.beginPath()
        currentContext.move(to: CGPoint.init(x: self.frame.size.width/4, y: self.frame.size.height/2))
        currentContext.addLine(to: CGPoint.init(x: self.frame.size.width * 3/4, y: self.frame.size.height/2))
        currentContext.move(to: CGPoint.init(x: self.frame.size.width/2, y: self.frame.size.height/4))
        currentContext.addLine(to: CGPoint.init(x: self.frame.size.width/2, y: self.frame.size.height * 3/4))
        currentContext.strokePath()

        // 绘制刻度
        currentContext.setLineWidth(0.8)
        currentContext.setLineCap(.round)
        currentContext.setAllowsAntialiasing(true)
        
        let centerX = Double(self.frame.size.width/2)
        let centerY = Double(self.frame.size.height/2)
        let radius =  Double(self.frame.size.width/2 - 40)
        for i in 0..<360{
            var lineLength = 10.0
            if i % 5 == 0{
                lineLength = 14.0
            }
            let degree = Double(i) / 180.0  * Double.pi
            let endX = centerX + (radius - lineLength) * cos(degree)
            let endY  = centerY + (radius - lineLength) * sin(degree)
            let startX = centerX + radius * cos(degree)
            let stratY = centerY + radius * sin(degree)

            currentContext.move(to: CGPoint.init(x: startX, y: stratY))
            currentContext.addLine(to: CGPoint.init(x: endX, y:endY))
            currentContext.strokePath()
        }
        
        // 绘制刻度
//        let array = ["N","W","S","E"]
    }

}
