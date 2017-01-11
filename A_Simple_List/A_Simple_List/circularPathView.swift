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
    
    let circlePath = UIBezierPath(
        arcCenter: CGPoint(x:160,y:160),
        radius: CGFloat(159),
        startAngle: CGFloat(-M_PI/2),
        endAngle:CGFloat(M_PI*(3/2)),
        clockwise: true)
    
    var trackColor = FocusElement?.color
    var repeatDuration = FocusElement?.timeLeftInSec
    let desiredLineWidth: CGFloat = 2  // your desired value
    let shapeLayer = CAShapeLayer()
    let backLayer = CAShapeLayer()
    
    override func draw(_ Rect: CGRect){
        drawAnimation()
    }
    
    func drawAnimation(){
        
        let animation = CABasicAnimation(keyPath:"strokeEnd")
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = trackColor?.withAlphaComponent(0.7).cgColor
        shapeLayer.lineWidth = desiredLineWidth
        backLayer.path = circlePath.cgPath
        backLayer.fillColor = UIColor.clear.cgColor
        backLayer.strokeColor = grey_.withAlphaComponent(0.05).cgColor
        backLayer.lineWidth = desiredLineWidth
        animation.duration = 3600
        animation.fromValue = 0
        animation.toValue = 1
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = true
        animation.repeatDuration = Double(repeatDuration!)
        shapeLayer.add(animation, forKey: "strokeEnd")
        
        layer.addSublayer(shapeLayer)
        layer.addSublayer(backLayer)
    }
    
}
