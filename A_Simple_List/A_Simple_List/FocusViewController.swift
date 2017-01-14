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
    @IBOutlet weak var statusBar: UILabel!
    
    var motionManager: CMMotionManager!//motion
    var progress = 1 - (Float((FocusElement?.timeLeft!)!)/Float((FocusElement?.timeInterval!)!))
    
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
    
    //refresh status bar
    var count:Int = 0
    
    func refreshStatusBar(){
        
        refresh()
        _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(refresh), userInfo: nil, repeats: true)
    }
    
    func refresh(){
        
        UIView.transition(with: statusBar, duration: 1, options: [.transitionCrossDissolve], animations: {self.count += 1
            let hour = getCurrentTimeComponents().hour
            let minute = getCurrentTimeComponents().minute
            var minString = ""
            var hrString = ""
            if (self.count > 5 && self.count <= 10){
                self.statusBar.text = String(dueList.count) + " dues left"
                if (self.count == 10) {self.count = 0}}
            else{
                if (hour! < 10) {hrString = "0" + String(hour!)}
                else {hrString = String(hour!)}
                if (minute! < 10) {minString = "0" + String(minute!)}
                else {minString = String(minute!)}
                self.statusBar.text = hrString + ":" + minString
            }}, completion: nil)
    }

    
    var myTimer: Timer?
    var start: DateComponents?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshStatusBar()
        
        start = getCurrentTimeComponents()
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
        if (hr! > 24){
            countDownLabel.text = String(Int(hr!/24)) + "days" + String(hr!%24) + "hrs left"
        }
        else {
            countDownLabel.text = String(hr!) + "hrs" + String(min) + "mins left"
        }
        countDownLabel.textColor = grey_.withAlphaComponent(0.5)
        progressBar.setProgress(progress, animated: true)
        progressBar.progressTintColor = FocusElement?.color?.withAlphaComponent(0.7)
        progressBar.trackTintColor = FocusElement?.color?.withAlphaComponent(0.2)
        progressBar.layer.cornerRadius = 8
        progressBar.layer.masksToBounds = true
    }
    
    
    
    func updateTimeStayed(){
        let current = getCurrentTimeComponents()
        let currentTime = Calendar.current.date(from: DateComponents(calendar: nil, timeZone: nil, era: nil, year: current.year, month: current.month, day: current.day, hour: current.hour, minute: current.minute, second: current.second, nanosecond: nil, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil))
        let startTime = Calendar.current.date(from: DateComponents(calendar: nil, timeZone: nil, era: nil, year: start?.year, month: start?.month, day: start?.day, hour: start?.hour, minute: start?.minute, second: start?.second, nanosecond: nil, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil))
        let hr = (currentTime?.hours(from: startTime!))!
        let min = (currentTime?.minutes(from: startTime!))! - hr*60
        let sec = (currentTime?.seconds(from: startTime!))! - hr*3600 - min*60
        var minString: String = ""
        var secString: String = ""
        var hrString: String = ""
        if (hr < 10) {hrString = "0" + String(hr) + ":"}
        else {hrString = String(hr) + ":"}
        if (min < 10 ) {minString = "0" + String(min) + ":"}
        else {minString = String(min) + ":"}
        if (sec < 10) {secString = "0" + String(sec)}
        else {secString = String(sec)}
        focusHourLabel.textColor = FocusElement?.color?.withAlphaComponent(0.7)
        focusHourLabel.text = hrString + minString + secString
        
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
