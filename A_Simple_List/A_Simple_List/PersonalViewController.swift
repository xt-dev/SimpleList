//
//  PersonalViewController.swift
//  A_Simple_List
//
//  Created by Derek Wu on 2017/1/7.
//  Copyright © 2017年 Xintong Wu. All rights reserved.
//

import Foundation
import UIKit
import Charts

//Global Variable
var dueTotalHour: Double = 3.0 //record total hours in the forcus mode
var totalTaskCount: Double = 12.0 //count the number of tasks user input
var finishedTaskCount: Double = 2.0 //count the number of tasks that are finished
var failedTaskCount: Double = 3.0 //count the number of tasks that are not finished before the due

var contentList = ["FocusHour", "Total Tasks", "Finished Tasks", "Failed Tasks"]
var countList = [dueTotalHour, totalTaskCount, finishedTaskCount, failedTaskCount]


class PersonalViewController: UIViewController_, UITableViewDelegate, UITableViewDataSource{
    
    //Links
    @IBOutlet weak var ContentList: UITableView!
    
    //Gesture Control
    //Right to left Edge Pan Gesture
    func createRightEdgePanGestureRecognizer(targetView: UIView){
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(self.RightEdgePanHandler(_:)))
        edgePan.edges = .right
        targetView.addGestureRecognizer(edgePan)
    }
    func RightEdgePanHandler(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "LVC")
            self.present(secondViewController!, animated: false, completion: nil)
        }
    }
    

    //Functions
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 4 //Four cells
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0){
            return 0
        }
        return 3
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = background_
        return view
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: ContentListCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ContentListCell
        cell.contentLabel.text = contentList[indexPath[0]]
        print(totalTaskCount)
        print(contentList[indexPath[0]])
        print(countList[indexPath[0]])
        cell.numberLabel.text = String(countList[indexPath[0]])
        
        return cell
    }
    
    override func viewDidAppear(_ animated: Bool) {
        ContentList.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var rect = view.bounds
        rect.origin.y = -130
        rect.size.height -= 40
        let chartView = PieChartView(frame: rect)
        let inprogress = totalTaskCount-finishedTaskCount-failedTaskCount
        let entries = [
            PieChartDataEntry(value: inprogress, label: "In Progress"),
            PieChartDataEntry(value: finishedTaskCount, label: "Finished"),
            PieChartDataEntry(value: failedTaskCount, label: "Failed")
        ]
        let set = PieChartDataSet(values: entries, label: "Data")
        set.highlightEnabled = false //highlight color?
        set.valueTextColor = .black //text color 总的
        set.entryLabelColor = .blue //label color
        //other settings: change something in the piechart view
        
        
        set.colors = ChartColorTemplates.material()//set the color
        chartView.data = PieChartData(dataSet: set)
        chartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)//, easingX: .EaseInCubic, easingY: .EaseInCubic)
        chartView.legend.enabled = false
        view.addSubview(chartView)
        
        createRightEdgePanGestureRecognizer(targetView: self.view)
        createRightEdgePanGestureRecognizer(targetView: self.ContentList)
        createRightEdgePanGestureRecognizer(targetView: chartView)
        
        //Disable scroll
        ContentList.isScrollEnabled = false;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
