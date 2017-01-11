//
//  DueElement.swift
//  FlowerAndTheBoy
//
//  Created by Derek Wu on 2016/12/31.
//  Copyright © 2016年 Xintong Wu. All rights reserved.
//

import Foundation
import UIKit

class DueElement{
    
    var dueName: String?
    var dueDate: time?
    var dueMonth_string: String?//represent month as a string
    var createdDate: time?
    
    //helper variable
    var timeInterval: Int?
    var timeLeft: Int?
    var timeLeftInMin: Int?
    var timeLeftInSec: Int?
    var color: UIColor?
    var finishDate: time?
    var finishMonth_string: String?
    var finishProgress: Float?
    
    init(dueName: String, dueDate: time, createdDate: time){
        self.dueName = dueName
        self.dueDate = dueDate
        self.timeInterval = dueDate.inputDate?.hours(from: (createdDate.inputDate)!)
        self.timeLeft = dueDate.inputDate?.hours(from: (dueDate.currentDate)!)
        self.timeLeftInMin = dueDate.inputDate?.minutes(from: (dueDate.currentDate)!)
        self.timeLeftInSec = dueDate.inputDate?.seconds(from: (dueDate.currentDate)!)
        if (Float(timeLeft!)/24.0 <= 1.0) {color = red_}
        else if (Float(timeLeft!)/24.0 <= 2.0) {color = yellow_}
        else {color = green_}
        switch dueDate.month! {
        case 1:
            self.dueMonth_string = "Jan"
        case 2:
            self.dueMonth_string = "Feb"
        case 3:
            self.dueMonth_string = "Mar"
        case 4:
            self.dueMonth_string = "Apr"
        case 5:
            self.dueMonth_string = "May"
        case 6:
            self.dueMonth_string = "Jun"
        case 7:
            self.dueMonth_string = "Jul"
        case 8:
            self.dueMonth_string = "Aug"
        case 9:
            self.dueMonth_string = "Sep"
        case 10:
            self.dueMonth_string = "Oct"
        case 11:
            self.dueMonth_string = "Nov"
        case 12:
            self.dueMonth_string = "Dec"
        default:
            self.dueMonth_string = "invalid"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func refreshData(){
        let dates = NSDate()
        let current = Calendar.current
        let dueDate = current.date(from: DateComponents(calendar: nil, timeZone: nil, era: nil, year: self.dueDate!.year!, month: self.dueDate!.month!, day: self.dueDate!.date!, hour: self.dueDate!.hour!, minute: self.dueDate!.minute!, second: nil, nanosecond: nil, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil))!
        let currentDate = current.date(from: DateComponents(calendar: nil, timeZone: nil, era: nil, year: current.component(.year, from: dates as Date), month: current.component(.month, from: dates as Date), day: current.component(.day, from: dates as Date), hour: current.component(.hour, from: dates as Date), minute: current.component(.minute, from: dates as Date), second: nil, nanosecond: nil, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil))
        self.timeLeft = dueDate.hours(from: (currentDate)!)
        self.timeLeftInMin = dueDate.minutes(from: (currentDate)!)
        self.timeLeftInSec = dueDate.seconds(from: (currentDate)!)
        if (Float(timeLeft!)/24.0 <= 1.0) {color = red_}
        else if (Float(timeLeft!)/24.0 <= 2.0) {color = yellow_}
        else {color = green_}
    }
    
    func getDueYearText()->String{
        let year: Int? = self.dueDate?.year
        let s: String = String(year!)
        return s
    }
    
    func getFinishYearText()->String{
        let year: Int? = self.finishDate?.year
        let s: String = String(year!)
        return s
    }
    
    func getDueMonthText()->String{
        let month: Int? = self.dueDate?.month
        let s: String = String(month!)
        return s
    }
    
    func getDueDateText()->String{
        let date: Int? = self.dueDate?.date
        let s: String = String(date!)
        return s
    }
    
    func getFinishDateText()->String{
        let date: Int? = self.finishDate?.date
        let s: String = String(date!)
        return s
    }
    
    func isLessInFinishDate(element: DueElement)->Bool{
        if (self.finishDate?.month)! > (element.finishDate?.month)!{return false}
        if (self.finishDate?.date)! > (element.finishDate?.date)!{return false}
        return true
    }
    
    func isLessInTimeLeft(element: DueElement)->Bool{
        return self.timeLeft!<element.timeLeft!
    }
    //fill in the month_string automatically
    func monthStringInput(month: Int){
        switch month {
        case 1:
            self.finishMonth_string = "Jan"
        case 2:
            self.finishMonth_string = "Feb"
        case 3:
            self.finishMonth_string = "Mar"
        case 4:
            self.finishMonth_string = "Apr"
        case 5:
            self.finishMonth_string = "May"
        case 6:
            self.finishMonth_string = "Jun"
        case 7:
            self.finishMonth_string = "Jul"
        case 8:
            self.finishMonth_string = "Aug"
        case 9:
            self.finishMonth_string = "Sep"
        case 10:
            self.finishMonth_string = "Oct"
        case 11:
            self.finishMonth_string = "Nov"
        case 12:
            self.finishMonth_string = "Dec"
        default:
            self.finishMonth_string = "invalid"
        }
    }
}


