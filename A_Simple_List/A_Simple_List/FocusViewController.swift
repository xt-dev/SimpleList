//
//  FocusViewController.swift
//  A_Simple_List
//
//  Created by Derek Wu on 2017/1/5.
//  Copyright © 2017年 Xintong Wu. All rights reserved.
//

import Foundation
import UIKit
import CoreMotion

class FocusViewController: UIViewController_{
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var focusHourLabel: UILabel!
    @IBOutlet weak var countDownLabel: UILabel!
    @IBOutlet weak var circularPath: circularPathView!
    
    var motionManager: CMMotionManager!//motion
    
    let duration = FocusElement!.timeLeftInSec!
    var currDuration = FocusElement!.timeLeftInSec!
    var secStayed = 0
    var minStayed = 0
    var hrStayed = 0
    var secStayedinHr = 0
    var minString: String = ""
    var secString: String = ""
    var hrString: String = ""
    var min = FocusElement!.timeLeftInMin! - FocusElement!.timeLeft!*60
    var sec = FocusElement!.timeLeftInSec! - FocusElement!.timeLeftInMin!*60
    var hr = FocusElement!.timeLeft!
    
    //detect shake motion and send alert
//    override var canBecomeFirstResponder: Bool {
//        return true
//    }
//    
//    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
//        if motion == .motionShake {
//            let alertController = UIAlertController(title: "Focus on your task!", message: "Put down your phone", preferredStyle: .alert)
//            
//            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//            alertController.addAction(defaultAction)
//            
//            present(alertController, animated: true, completion: nil)
//        }
//    }
    
    //Long Press Gesture Constructor
    func createLongPressGestureRecognizer(targetView: UIView)
    {
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.longPress(_:)))
        targetView.addGestureRecognizer(longPressRecognizer)
    }
    //Long press Gesture Handler
    func longPress(_ sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.began {
                let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "LVC")
                self.present(secondViewController!, animated: false, completion: nil)
                FocusElement = nil
        }
    }
    
    var myTimer: Timer?
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        circularPath.backgroundColor = UIColor.clear
        taskNameLabel.text = FocusElement!.dueName!
        
        myTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        
        createLongPressGestureRecognizer(targetView: circularPath)
        
//        motionManager = CMMotionManager()
//        motionManager.accelerometerUpdateInterval = 1
//        motionManager.startAccelerometerUpdates()
//        print(motionManager.isAccelerometerAvailable)
//        
//        if let accelerometerData = motionManager.accelerometerData {
//            print("monitoring")
//            print(accelerometerData.acceleration.x)
//            print(accelerometerData.acceleration.y)
//            print(accelerometerData.acceleration.z)
//
//        }

    }
    
    func update(){
        updateTimeLeft()
        updateTimeStayed()
    }
    
    func timesup(){
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "LVC")
        self.present(secondViewController!, animated: true, completion: nil)
        myTimer?.invalidate()
        myTimer = nil
    }
    
    func updateTimeLeft(){
        if (currDuration > 0) {currDuration -= 1}
        sec -= 1
        if (sec <= 0 && min <= 0 && hr <= 0){
            hrString = "00:"
            minString = "00:"
            secString = "00"
            let alertController = UIAlertController(title: "Focus Mode", message: "Due has passed!", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: {action in self.timesup()}))
            self.present(alertController, animated: true, completion: nil)
        }
        else {
            if (sec < 0){
                if (min < 0){
                    hr -= 1
                    min = 59
                    sec = 59
                }
                else {
                    min -= 1
                    sec = 59
                }
            }
            if (hr < 10 ) {hrString = "0" + String(hr) + ":"}
            else {hrString = String(hr) + ":"}
            if (min < 10 ) {minString = "0" + String(min) + ":"}
            else {minString = String(min) + ":"}
            if (sec < 10 ) {secString = "0" + String(sec)}
            else {secString = String(sec)}
        }
        //        countDownLabel.font = UIFont(name: "Helvetica", size: 36)
        countDownLabel.text = hrString + minString + secString
        if (Double(currDuration)/Double(duration) > 0.5) {countDownLabel.textColor = green_}
        else if (Double(currDuration)/Double(duration) > 0.25) {countDownLabel.textColor = yellow_}
        else {countDownLabel.textColor = red_}
    }
    
    func updateTimeStayed(){
        secStayed += 1
        secStayedinHr += 1
        if (secStayed == 60){
            if (minStayed == 60){
                hrStayed += 1
                secStayed = 0
                minStayed = 0
            }
            else {
                minStayed += 1
                secStayed = 0
            }
        }
        if (secStayedinHr == 3600){secStayedinHr = 0}
        progressBar.setProgress(Float(secStayedinHr)/3600.0, animated: false)
        progressBar.backgroundColor = UIColor.lightGray
        progressBar.progressTintColor = UIColor.darkGray
        focusHourLabel.text = String(hrStayed) + "hrs" + String(minStayed) + "mins"
    }
    /*
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
     */
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
