//
//  Extension.swift
//  A_Simple_List
//
//  Created by Derek Wu on 2017/1/3.
//  Copyright © 2017年 Xintong Wu. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications
import UserNotificationsUI

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

//get current time
func getCurrentTimeComponents()->DateComponents{
    let cur_date = NSDate()
    let calender = NSCalendar.current
    let components = calender.dateComponents([.year, .month, .day, .hour, .minute, .second], from: cur_date as Date)
    return components
}


extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, isLargerAlpha: Float) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(isLargerAlpha))
        
    }
    
    convenience init(netHex:Int, isLargerAlpha: Float) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff, isLargerAlpha: isLargerAlpha)
    }
}

//color reference
var green_: UIColor = UIColor.init(netHex: 0x1abc9c, isLargerAlpha: 1)
var yellow_: UIColor = UIColor.init(netHex: 0xf1c40f, isLargerAlpha: 1)
var red_: UIColor = UIColor.init(netHex: 0xec644b, isLargerAlpha: 1)
var grey_: UIColor = UIColor.init(netHex: 0x757478, isLargerAlpha: 1)
var background_: UIColor = UIColor.init(netHex: 0xECF0F1, isLargerAlpha: 1)

//Debug constrain
extension NSLayoutConstraint {
    
    override open var description: String {
        let id = identifier ?? ""
        return "id: \(id), constant: \(constant)" //you may print whatever you want here
    }
}

extension ListViewController:UNUserNotificationCenterDelegate{
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        print("Tapped in notification")
    }
    
    //This is key callback to present notification while the app is in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print("Notification being triggered")
        //You can either present alert ,sound or increase badge while the app is in foreground too with ios 10
        //to distinguish between notifications
        if notification.request.identifier == requestIdentifier{
            
            completionHandler( [.alert,.sound,.badge])
            
        }
    }
}

//Images
let cross_use = imageWithImage(image: UIImage(named: "删除标记")!, scaledToSize: CGSize(width: 28, height: 28))
let check_use = imageWithImage(image: UIImage(named: "确认标记")!, scaledToSize: CGSize(width: 28, height: 28))
let arrow_use = imageWithImage(image: UIImage(named: "向左箭头")!, scaledToSize: CGSize(width: 28, height: 28))


//resize image
func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
    UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
    image.draw(in: CGRect(origin: CGPoint.zero, size: CGSize(width: newSize.width, height: newSize.height)))
    let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return newImage
}

//extension UIProgressView {
//    
//    @IBInspectable var barHeight : CGFloat {
//        get {
//            return transform.d * 10.0
//        }
//        set {
//            // 2.0 Refers to the default height of 2
//            let heightScale = 12.0 / 2.0
//            let c = center
//            transform = CGAffineTransform(scaleX: 1.0, y: CGFloat(heightScale))
//            center = c
//        }
//    }
//}

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
