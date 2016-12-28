//
//  DueElement.swift
//  DueList
//
//  Created by Derek Wu on 2016/12/28.
//  Copyright © 2016年 Xintong Wu. All rights reserved.
//

import Foundation
import UIKit

struct time{
    
    var month: Calendar.Component?
    var date: Calendar.Component?
    var hour: Calendar.Component?
    init(month: Calendar.Component?, date: Calendar.Component?, hour: Calendar.Component?){
        self.month = month
        self.date = date
        self.hour = hour
    }
    
}

class DueElement{
    
    var dueName: String?
    var dueDate: time?
    //helper variable
    var timeLeft: time?
    var color:UIColor?
    var createDate: time?
    //reference
    let setToYellow = 2; //2days
    let setToRed = 1; //1days left
    
    init(){
        dueName = ""
        dueDate = time(month: Calendar.Component.month, date: Calendar.Component.day, hour: Calendar.Component.hour)
        timeLeft = time(month: Calendar.Component.month, date: Calendar.Component.day, hour: Calendar.Component.hour)
        
        color = UIColor.green
        createDate = time(month: Calendar.Component.month, date: Calendar.Component.day, hour: Calendar.Component.hour)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
