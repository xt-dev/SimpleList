//
//  FocusViewController.swift
//  A_Simple_List
//
//  Created by Derek Wu on 2017/1/5.
//  Copyright © 2017年 Xintong Wu. All rights reserved.
//

import Foundation
import UIKit

class FocusViewController: UIViewController_{
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var focusHourLabel: UILabel!
    @IBOutlet weak var countDownLabel: UILabel!
    @IBOutlet weak var circularPath: circularPathView!
    
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskNameLabel.text = FocusElement!.dueName!
        
        _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        
        // Do any additional setup after loading the view, typically from a nib.
        /*let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panedView(sender: )))
         
         self.circularPath.addGestureRecognizer(panRecognizer)
         
         circularPath.isUserInteractionEnabled = true
         */
    }
    
    func update(){
        updateTimeLeft()
        updateTimeStayed()
    }
    
    func updateTimeLeft(){
        if (currDuration > 0) {currDuration -= 1}
        sec -= 1
        if (sec < 0 && min < 0 && hr < 0){
            hrString = ""
            minString = "00"
            secString = "00"
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
        }
        if (hr == 0) {hrString = ""}
        else if (hr < 10) {hrString = "0" + String(hr) + ":"}
        else {hrString = String(hr) + ":"}
        if (min < 10) {minString = "0" + String(min) + ":"}
        else {minString = String(min) + ":"}
        if (sec < 10) {secString = "0" + String(sec)}
        else {secString = String(sec)}
        countDownLabel.font = UIFont(name: "Helvetica", size: 36)
        countDownLabel.text = hrString + minString + secString
        if (Double(currDuration)/Double(duration) > 0.5) {countDownLabel.textColor = UIColor.green}
        else if (Double(currDuration)/Double(duration) > 0.25) {countDownLabel.textColor = UIColor.yellow}
        else {countDownLabel.textColor = UIColor.red}
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
        focusHourLabel.font = UIFont(name: "Helvetica", size: 12)
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
