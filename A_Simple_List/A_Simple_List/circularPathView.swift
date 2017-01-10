//
//  circularPathView.swift
//  A_Simple_List
//
//  Created by zerofuture on 12/31/16.
//  Copyright © 2016 Xintong Wu. All rights reserved.
//

import Foundation
import UIKit


class circularPathView: UIView{
    
    let greenCirclePath = UIBezierPath(
        arcCenter: CGPoint(x:160,y:160),
        radius: CGFloat(159),
        startAngle: CGFloat(-M_PI/2),
        endAngle:CGFloat(M_PI/2),
        clockwise: true)
    let yellowCirclePath = UIBezierPath(
        arcCenter: CGPoint(x:160,y:160),
        radius: CGFloat(159),
        startAngle: CGFloat(M_PI/2),
        endAngle:CGFloat(M_PI),
        clockwise: true)
    let redCirclePath = UIBezierPath(
        arcCenter: CGPoint(x:160,y:160),
        radius: CGFloat(159),
        startAngle: CGFloat(M_PI),
        endAngle:CGFloat(M_PI*(3/2)),
        clockwise: true)
    
    var duration = FocusElement?.timeLeftInSec
    let desiredLineWidth: CGFloat = 2  // your desired value
    let redShapeLayer = CAShapeLayer()
    let yellowShapeLayer = CAShapeLayer()
    let greenShapeLayer = CAShapeLayer()
    let redBackLayer = CAShapeLayer()
    let yellowBackLayer = CAShapeLayer()
    let greenBackLayer = CAShapeLayer()
    
    override func draw(_ Rect: CGRect){
        
        Timer.scheduledTimer(timeInterval: 0, target: self,
                             selector: #selector(circularPathView.drawGreenAnimation),
                             userInfo: nil, repeats: false)
        Timer.scheduledTimer(timeInterval: Double(duration!)*0.5, target: self,
                             selector: #selector(circularPathView.drawYellowAnimation),
                             userInfo: nil, repeats: false)
        Timer.scheduledTimer(timeInterval: Double(duration!)*0.75, target: self,
                             selector: #selector(circularPathView.drawRedAnimation),
                             userInfo: nil, repeats: false)
        
    }
    
    func drawRedAnimation(){
        
        let redAnimation = CABasicAnimation(keyPath:"strokeEnd")
        redShapeLayer.path = redCirclePath.cgPath
        redShapeLayer.fillColor = UIColor.clear.cgColor
        redShapeLayer.strokeColor = red_.withAlphaComponent(0.7).cgColor
        redShapeLayer.lineWidth = desiredLineWidth
        redAnimation.duration = Double(duration!)*0.25
        redAnimation.fromValue = 0
        redAnimation.toValue = 1
        redAnimation.fillMode = kCAFillModeForwards
        redAnimation.isRemovedOnCompletion = false
        redShapeLayer.add(redAnimation, forKey: "strokeEnd")
        greenShapeLayer.strokeColor = redShapeLayer.strokeColor
        greenShapeLayer.fillColor = redShapeLayer.fillColor
        yellowShapeLayer.strokeColor = redShapeLayer.strokeColor
        yellowShapeLayer.fillColor = redShapeLayer.fillColor
        yellowBackLayer.strokeColor = UIColor.clear.cgColor
        //        redBackLayer.strokeColor = red_.withAlphaComponent(0.2).cgColor
        layer.addSublayer(redShapeLayer)
    }
    
    func drawGreenAnimation(){
        let greenAnimation = CABasicAnimation(keyPath:"strokeEnd")
        greenShapeLayer.path = greenCirclePath.cgPath
        greenShapeLayer.fillColor = UIColor.clear.cgColor
        greenShapeLayer.strokeColor = green_.withAlphaComponent(0.7).cgColor
        greenShapeLayer.lineWidth = desiredLineWidth
        
        greenBackLayer.path = greenCirclePath.cgPath
        greenBackLayer.fillColor = UIColor.clear.cgColor
        greenBackLayer.strokeColor = grey_.withAlphaComponent(0.05).cgColor
        greenBackLayer.lineWidth = desiredLineWidth
        
        yellowBackLayer.path = yellowCirclePath.cgPath
        yellowBackLayer.fillColor = UIColor.clear.cgColor
        yellowBackLayer.strokeColor = grey_.withAlphaComponent(0.05).cgColor
        yellowBackLayer.lineWidth = desiredLineWidth
        
        redBackLayer.path = redCirclePath.cgPath
        redBackLayer.fillColor = UIColor.clear.cgColor
        redBackLayer.strokeColor = grey_.withAlphaComponent(0.05).cgColor
        redBackLayer.lineWidth = desiredLineWidth
        
        greenAnimation.duration = Double(duration!)*0.5
        greenAnimation.fromValue = 0
        greenAnimation.toValue = 1
        greenAnimation.fillMode = kCAFillModeForwards
        greenAnimation.isRemovedOnCompletion = false
        greenShapeLayer.add(greenAnimation, forKey: "strokeEnd")
        layer.addSublayer(greenShapeLayer)
        layer.addSublayer(greenBackLayer)
        layer.addSublayer(yellowBackLayer)
        layer.addSublayer(redBackLayer)
    }
    
    func drawYellowAnimation(){
        let yellowAnimation = CABasicAnimation(keyPath:"strokeEnd")
        yellowShapeLayer.path = yellowCirclePath.cgPath
        yellowShapeLayer.fillColor = UIColor.clear.cgColor
        yellowShapeLayer.strokeColor = yellow_.withAlphaComponent(0.7).cgColor
        yellowShapeLayer.lineWidth = desiredLineWidth
        
        yellowAnimation.duration = Double(duration!)*0.25
        yellowAnimation.fromValue = 0
        yellowAnimation.toValue = 1
        yellowAnimation.fillMode = kCAFillModeForwards
        yellowAnimation.isRemovedOnCompletion = false
        yellowShapeLayer.add(yellowAnimation, forKey: "strokeEnd")
        greenShapeLayer.strokeColor = yellowShapeLayer.strokeColor
        greenShapeLayer.fillColor = yellowShapeLayer.fillColor
        
        greenBackLayer.strokeColor = UIColor.clear.cgColor
        //        yellowBackLayer.strokeColor = yellow_.withAlphaComponent(0.2).cgColor
        //        redBackLayer.strokeColor = yellow_.withAlphaComponent(0.2).cgColor
        layer.addSublayer(yellowShapeLayer)
    }
}
