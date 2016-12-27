//
//  DueElementCell.swift
//  DueList
//
//  Created by Derek Wu on 2016/12/24.
//  Copyright © 2016年 Xintong Wu. All rights reserved.
//

/*import Foundation
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

class DueElementCell: UITableViewCell{
    
    var dueName: String?
    var dueDate = time(month: Calendar.Component.month, date: Calendar.Component.day, hour: Calendar.Component.hour)
    
    //helper variable
    var timeLeft = time(month: Calendar.Component.month, date: Calendar.Component.day, hour: Calendar.Component.hour)
    
    var color = UIColor.green
    var createDate = time(month: Calendar.Component.month, date: Calendar.Component.day, hour: Calendar.Component.hour)
    //reference
    let setToYellow = 2; //2days
    let setToRed = 1; //1days left
    
    //UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
    init(){
        super.init(style: UITableViewCellStyle.default, reuseIdentifier:"cell")
        dueName = ""
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}*/
import UIKit
class DueElementCell: UITableViewCell{
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
}

