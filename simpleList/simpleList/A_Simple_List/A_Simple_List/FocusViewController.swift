//
//  FocusViewController.swift
//  A_Simple_List
//
//  Created by zerofuture on 12/31/16.
//  Copyright © 2016 Xintong Wu. All rights reserved.
//

import Foundation
import UIKit

class FocusViewController: UIViewController {
    

    
    @IBOutlet weak var countDownLabel: UILabel!
    @IBOutlet weak var point: pointView!
    @IBOutlet weak var circularPath: circularPathView!
    var minString: String?
    var secString: String?
    var hrString: String?
    var min = 00
    var sec = 00
    var hr = 00
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panedView(sender: )))
        
        self.circularPath.addGestureRecognizer(panRecognizer)

        circularPath.isUserInteractionEnabled = true
        
        minString = "00"
        secString = "00"
        countDownLabel.text = minString! + ":" + secString!
       
        let radius = 125
        point.frame.origin.x = 125
        point.frame.origin.y = 0
        point.backgroundColor = UIColor.clear
        let keyFrameAnimation = CAKeyframeAnimation(keyPath:"position")
        let mutablePath = UIBezierPath(arcCenter: CGPoint(x: circularPath.frame.width/2, y: circularPath.frame.height/2), radius: CGFloat(radius)-7.5, startAngle: CGFloat(M_PI * -0.5), endAngle: CGFloat(M_PI * 0.5), clockwise: true).cgPath
        keyFrameAnimation.path = mutablePath
        keyFrameAnimation.duration = 3
        keyFrameAnimation.fillMode = kCAFillModeForwards
        keyFrameAnimation.isRemovedOnCompletion = false
        self.point.layer.add(keyFrameAnimation, forKey: "animation")
        
    }
    
    func update() {
        if(min > 0) {
            min -= 1
            countDownLabel.text = String(min)
        }
    }
    
    func panedView(sender: UIPanGestureRecognizer){
        let translation = sender.translation(in: circularPath)
        let startPoint = CGPoint(x: 0, y: 0)
        sender.setTranslation(startPoint, in: circularPath)
        let currentLocation = translation.y
        min -= Int(currentLocation/5)
        if (min < 0 && hr < 1) {min = 0}
        else if (min < 0 && hr >= 1) {
            min = 60
            hr -= 1
            hrString = String(hr)
        }
        else if (min < 10) {minString = "0" + String(min)}
        else if (min >= 10 && min < 60){minString = String(min)}
        else if (min >= 60) {
            min = 0
            hr += 1
            hrString = String(hr)
        }
        
        if (hr >= 1){
            countDownLabel.text = hrString! + ":" + minString! + ":" + secString!
        }
        else{
            countDownLabel.text = minString! + ":" + secString!
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
