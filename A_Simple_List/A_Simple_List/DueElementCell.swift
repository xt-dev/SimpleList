//
//  DueElementCell.swift
//  A_Simple_List
//
//  Created by Derek Wu on 2016/12/31.
//  Copyright © 2016年 Xintong Wu. All rights reserved.
//

import Foundation
import UIKit
import MCSwipeTableViewCell

//text colors
var textColor_custom = UIColor.init(netHex: 0x757478, isLargerAlpha: 1)


class DueElementCell: MCSwipeTableViewCell{
    @IBOutlet weak var DueDateLabel: UILabel!
    @IBOutlet weak var DueNameLabel: UILabel!
    @IBOutlet weak var TimeLeftLabel: UILabel!
    @IBOutlet weak var ProgressBar: UIProgressView!
    
    var transformed: Bool = false
    
    //override to make text transparent when swiping
    override func setupSwipingView(){
        super.setupSwipingView()
        DueNameLabel.textColor = .white
        DueDateLabel.textColor = .white
        TimeLeftLabel.textColor = .white
        ProgressBar.isHidden = true
    }
    
    override func uninstallSwipingView(){
        super.uninstallSwipingView()
        DueNameLabel.textColor = textColor_custom
        DueDateLabel.textColor = textColor_custom
        TimeLeftLabel.textColor = textColor_custom
        ProgressBar.isHidden = false
    }
    
}
