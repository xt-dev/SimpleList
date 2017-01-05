//
//  DueElement.swift
//  FlowerAndTheBoy
//
//  Created by Derek Wu on 2016/12/31.
//  Copyright © 2016年 Xintong Wu. All rights reserved.
//

import Foundation
import UIKit

struct time{
    var year: Int?
    var month: Int?
    var date: Int?
    var hour: Int?
    var minute: Int?
    var inputDate: Date?
    var currentDate: Date?
    var current = NSCalendar.current
    let dates = NSDate()
    
    init(year: Int?, month: Int?, date: Int?, hour: Int?, minute: Int?){
        self.year = year
        self.month = month
        self.date = date
        self.hour = hour
        self.minute = minute
        self.current = Calendar.current
        inputDate = current.date(from: DateComponents(calendar: nil, timeZone: nil, era: nil, year: year, month: month, day: date, hour: hour, minute: minute, second: nil, nanosecond: nil, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil))!
        currentDate = current.date(from: DateComponents(calendar: nil, timeZone: nil, era: nil, year: current.component(.year, from: dates as Date), month: current.component(.month, from: dates as Date), day: current.component(.day, from: dates as Date), hour: current.component(.hour, from: dates as Date), minute: current.component(.minute, from: dates as Date), second: nil, nanosecond: nil, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil))
    }
}

class DueElement{
    
    var dueName: String?
    var dueDate: time?
    var createdDate: time?
    //helper variable
    var timeInterval: Int?
    var timeLeft: Int?
    var color: UIColor?
    var finishDate: time?

    
    init(dueName: String, dueDate: time, createdDate: time){
        self.dueName = dueName
        self.timeInterval = dueDate.inputDate?.hours(from: (createdDate.inputDate)!)
        self.timeLeft = dueDate.inputDate?.hours(from: (dueDate.currentDate)!)
        if (Float(timeLeft!)/24.0 <= 1.0) {color = UIColor.red}
        else if (Float(timeLeft!)/24.0 <= 2.0) {color = UIColor.yellow}
        else {color = UIColor.green}
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func isLessInFinishDate(element: DueElement)->Bool{
        if (self.finishDate?.month)! > (element.finishDate?.month)!{return false}
        if (self.finishDate?.date)! > (element.finishDate?.date)!{return false}
        return true
    }
    
    func isLessInTimeLeft(element: DueElement)->Bool{
        return self.timeLeft!<element.timeLeft!
    }
}
