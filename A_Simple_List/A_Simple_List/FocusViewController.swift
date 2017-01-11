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
    
    var secStayed = 0
    var minStayed = 0
    var hrStayed = 0
    var secStayedinHr = 0
    var minStayedString: String = ""
    var secStayedString: String = ""
    var hrStayedString: String = ""
    var progress = 1 - (Float((FocusElement?.timeLeft!)!)/Float((FocusElement?.timeInterval!)!))
    
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
                myTimer?.invalidate()
                myTimer = nil
                let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "LVC")
                self.present(secondViewController!, animated: false, completion: nil)
                FocusElement = nil
        }
    }
    
    var myTimer: Timer?
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        update()
        circularPath.backgroundColor = UIColor.clear
        taskNameLabel.text = FocusElement!.dueName!
        taskNameLabel.textColor = grey_.withAlphaComponent(0.7)
        progressBar.transform = progressBar.transform.scaledBy(x: 1, y: 7)
        
        myTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        
        createLongPressGestureRecognizer(targetView: circularPath)
        
        motionManager = CMMotionManager()
        motionManager.accelerometerUpdateInterval = 0.7
        motionManager.startAccelerometerUpdates()
        print(motionManager.isAccelerometerAvailable)
        
        motionManager.startAccelerometerUpdates(to: OperationQueue.main, withHandler: { (data, error) in
            if let accelerometerData = self.motionManager.accelerometerData {
                let x = accelerometerData.acceleration.x
                let y = accelerometerData.acceleration.y
                let z = accelerometerData.acceleration.z
                print("x : \(x * 1000)")
                print("y : \(y * 1000)")
                print("z : \(z * 1000)")
                print("sum : \(pow(x*100, 2) + pow(y*100, 2) + pow(z*100, 2))")
                if ((pow(x*100, 2) + pow(y*100, 2) + pow(z*100, 2)) > 12000 || (pow(x*100, 2) + pow(y*100, 2) + pow(z*100, 2)) < 8000)
                {
                    let alertController = UIAlertController(title: "Focus Mode", message: "Put Down Your Phone!", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "Okay...Okay", style: UIAlertActionStyle.default,handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        })
    }
    
    func update(){
        updateTimeLeft()
        updateTimeStayed()
    }
    
    func timesup(){
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "LVC")
        self.present(secondViewController!, animated: true, completion: nil)

    }
    
    func updateTimeLeft(){
        FocusElement?.refreshData()
        let min = (FocusElement?.timeLeftInMin!)! - (FocusElement?.timeLeft!)!*60
        let hr = FocusElement?.timeLeft!
        if ((FocusElement?.timeLeftInSec)! < 0) {
            myTimer?.invalidate()
            myTimer = nil
            let alertController = UIAlertController(title: "Focus Mode", message: "Due has passed!", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: {action in self.timesup()}))
            self.present(alertController, animated: true, completion: nil)
        }
        countDownLabel.text = String(hr!) + "hrs" + String(min) + "mins left"
        countDownLabel.textColor = grey_.withAlphaComponent(0.7)
        progressBar.setProgress(progress, animated: true)
        progressBar.backgroundColor = FocusElement?.color?.withAlphaComponent(0.2)
        progressBar.progressTintColor = FocusElement?.color?.withAlphaComponent(0.7)
        progressBar.layer.cornerRadius = 1
        progressBar.layer.masksToBounds = true
    }
    

        
    func updateTimeStayed(){
        secStayed += 1
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
        if (hrStayed < 10) {hrStayedString = "0" + String(hrStayed) + ":"}
        else {hrStayedString = String(hrStayed) + ":"}
        if (minStayed < 10 ) {minStayedString = "0" + String(minStayed) + ":"}
        else {minStayedString = String(minStayed) + ":"}
        if (secStayed < 10) {secStayedString = "0" + String(secStayed)}
        else {secStayedString = String(secStayed)}
        focusHourLabel.textColor = FocusElement?.color?.withAlphaComponent(0.7)
        focusHourLabel.text = hrStayedString + minStayedString + secStayedString
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
