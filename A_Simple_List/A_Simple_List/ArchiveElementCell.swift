//
//  ArchiveElementCell.swift
//  A_Simple_List
//
//  Created by 张瑞麟 on 2017/1/3.
//  Copyright © 2017年 Xintong Wu. All rights reserved.
//
import Foundation
import UIKit
import MCSwipeTableViewCell

class ArchiveElementCell:MCSwipeTableViewCell{
    
    @IBOutlet weak var DueNameLabel: UILabel!
    @IBOutlet weak var DueDateLabel: UILabel!
    @IBOutlet weak var FinishDateLabel: UILabel!
    @IBOutlet weak var ProgressBar: UIProgressView!
    
    var transformed: Bool = false
    
    //override to make text transparent when swipe
    override func setupSwipingView(){
        super.setupSwipingView()
        DueNameLabel.textColor = .white
        DueDateLabel.textColor = .white
        FinishDateLabel.textColor = .white
        ProgressBar.isHidden = true
    }
    
    override func uninstallSwipingView(){
        super.uninstallSwipingView()
        DueNameLabel.textColor = textColor_custom
        DueDateLabel.textColor = textColor_custom
        FinishDateLabel.textColor = textColor_custom
        ProgressBar.isHidden = false
}
}
