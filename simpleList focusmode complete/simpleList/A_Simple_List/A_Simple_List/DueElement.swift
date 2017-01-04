//
//  DueElement.swift
//  FlowerAndTheBoy
//
//  Created by Derek Wu on 2016/12/31.
//  Copyright © 2016年 Xintong Wu. All rights reserved.
//

import Foundation
import UIKit

extension Date {
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfYear], from: date, to: self).weekOfYear ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if years(from: date)   > 0 { return "\(years(from: date))y"   }
        if months(from: date)  > 0 { return "\(months(from: date))M"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
        if days(from: date)    > 0 { return "\(days(from: date))d"    }
        if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
        if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
        if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
        return ""
    }
}

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
        currentDate = current.date(from: DateComponents(calendar: nil, timeZone: nil, era: nil, year: current.component(.year, from: dates as Date), month: current.component(.month, from: dates as Date), day: current.component(.day, from: dates as Date), hour: current.component(.hour, from: dates as Date), minute: current.component(.minute, from: dates as Date), second: current.component(.second, from: dates as Date), nanosecond: nil, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil))
    }
}

class DueElement{
    
    var dueName: String?
    var dueDate: time?
    var createdDate: time?
    //helper variable
    var timeInterval: Int?
    var timeLeft: Int?
    var timeLeftInMin: Int?
    var timeLeftInSec: Int?
    var color: UIColor?
    
    init(dueName: String, dueDate: time, createdDate: time){
        self.dueName = dueName
        self.timeInterval = dueDate.inputDate?.hours(from: (createdDate.inputDate)!)
        self.timeLeft = dueDate.inputDate?.hours(from: (dueDate.currentDate)!)
        self.timeLeftInMin = dueDate.inputDate?.minutes(from: (dueDate.currentDate)!)
        self.timeLeftInSec = dueDate.inputDate?.seconds(from: (dueDate.currentDate)!)
        if (Float(timeLeft!)/24.0 <= 1.0) {color = UIColor.red}
        else if (Float(timeLeft!)/24.0 <= 2.0) {color = UIColor.yellow}
        else {color = UIColor.green}
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
