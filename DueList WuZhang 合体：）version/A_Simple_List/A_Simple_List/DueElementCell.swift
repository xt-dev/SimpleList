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

class DueElementCell: MCSwipeTableViewCell{
    @IBOutlet weak var DueDateLabel: UILabel!
    @IBOutlet weak var DueNameLabel: UILabel!
    @IBOutlet weak var TimeLeftLabel: UILabel!
    @IBOutlet weak var ProgressBar: UIProgressView!
    
    //override to make text transparent when swipe
    override func setupSwipingView(){
        super.setupSwipingView()
        DueNameLabel.textColor = .white
        DueDateLabel.textColor = .white
        TimeLeftLabel.textColor = .white
        ProgressBar.isHidden = true
    }
    
    override func uninstallSwipingView(){
        super.uninstallSwipingView()
        DueNameLabel.textColor = .black
        DueDateLabel.textColor = .black
        TimeLeftLabel.textColor = .black
        ProgressBar.isHidden = false
    }
    
}
