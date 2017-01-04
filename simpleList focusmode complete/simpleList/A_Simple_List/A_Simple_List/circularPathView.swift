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
    var duration = dueList[ 0].timeLeftInSec
    let desiredLineWidth: CGFloat = 2  // your desired value
    
    let greenCirclePath = UIBezierPath(
        arcCenter: CGPoint(x:125,y:125),
        radius: CGFloat( 124 ),
        startAngle: CGFloat(-M_PI/2),
        endAngle:CGFloat(M_PI/2),
        clockwise: true)
    let yellowCirclePath = UIBezierPath(
        arcCenter: CGPoint(x:125,y:125),
        radius: CGFloat( 124 ),
        startAngle: CGFloat(M_PI/2),
        endAngle:CGFloat(M_PI),
        clockwise: true)
    let redCirclePath = UIBezierPath(
        arcCenter: CGPoint(x:125,y:125),
        radius: CGFloat( 124 ),
        startAngle: CGFloat(M_PI),
        endAngle:CGFloat(M_PI*(3/2)),
        clockwise: true)
    let redShapeLayer = CAShapeLayer()
    let yellowShapeLayer = CAShapeLayer()
    let greenShapeLayer = CAShapeLayer()
    
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
        redShapeLayer.strokeColor = UIColor.red.withAlphaComponent(0.7).cgColor
        redShapeLayer.lineWidth = desiredLineWidth
        redAnimation.duration = Double(duration!)*0.25
        redAnimation.fromValue = 0
        redAnimation.toValue = 1
        redAnimation.fillMode = kCAFillModeForwards
        redAnimation.isRemovedOnCompletion = false
        redShapeLayer.add(redAnimation, forKey: "strokeEnd")
        greenShapeLayer.strokeColor = redShapeLayer.strokeColor
        yellowShapeLayer.strokeColor = redShapeLayer.strokeColor
        layer.addSublayer(redShapeLayer)
    }

    func drawGreenAnimation(){
        let greenAnimation = CABasicAnimation(keyPath:"strokeEnd")
        greenShapeLayer.path = greenCirclePath.cgPath
        greenShapeLayer.fillColor = UIColor.clear.cgColor
        greenShapeLayer.strokeColor = UIColor.green.withAlphaComponent(0.7).cgColor
        greenShapeLayer.lineWidth = desiredLineWidth
        greenAnimation.duration = Double(duration!)*0.5
        greenAnimation.fromValue = 0
        greenAnimation.toValue = 1
        greenAnimation.fillMode = kCAFillModeForwards
        greenAnimation.isRemovedOnCompletion = false
        greenShapeLayer.add(greenAnimation, forKey: "strokeEnd")
        layer.addSublayer(greenShapeLayer)
    }
    
    func drawYellowAnimation(){
        let yellowAnimation = CABasicAnimation(keyPath:"strokeEnd")
        yellowShapeLayer.path = yellowCirclePath.cgPath
        yellowShapeLayer.fillColor = UIColor.clear.cgColor
        yellowShapeLayer.strokeColor = UIColor.yellow.withAlphaComponent(0.7).cgColor
        yellowShapeLayer.lineWidth = desiredLineWidth
        yellowAnimation.duration = Double(duration!)*0.25
        yellowAnimation.fromValue = 0
        yellowAnimation.toValue = 1
        yellowAnimation.fillMode = kCAFillModeForwards
        yellowAnimation.isRemovedOnCompletion = false
        yellowShapeLayer.add(yellowAnimation, forKey: "strokeEnd")
        greenShapeLayer.strokeColor = yellowShapeLayer.strokeColor
        layer.addSublayer(yellowShapeLayer)
    }
}
