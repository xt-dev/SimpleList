//
//  ChartViewController.swift
//  A_Simple_List
//
//  Created by 张瑞麟 on 2017/1/4.
//  Copyright © 2017年 Xintong Wu. All rights reserved.
//

import Foundation
import UIKit
import Charts
import RealmSwift

class ChartViewController : UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var rect = view.bounds
        rect.origin.y += 20
        rect.size.height -= 20
        let chartView = PieChartView(frame: rect)
        let entries = [
            PieChartDataEntry(value: 5, label: "In Progress"),
            PieChartDataEntry(value: 20, label: "Finished"),
            PieChartDataEntry(value: 2, label: "Failed")
        ]
        let set = PieChartDataSet(values: entries, label: "Data")
        set.highlightEnabled = true //highlight color?
        
        set.valueTextColor = .black //text color 总的
        set.entryLabelColor = .blue //label color
        //other settings: change something in the piechart view
        
        
        set.colors = ChartColorTemplates.material()//set the color
        chartView.data = PieChartData(dataSet: set)
        chartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)//, easingX: .EaseInCubic, easingY: .EaseInCubic)
        view.addSubview(chartView)
    }
}

