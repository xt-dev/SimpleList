//
//  ArchiveViewController.swift
//  A_Simple_List
//
//  Created by Derek Wu on 2017/1/3.
//  Copyright © 2017年 Xintong Wu. All rights reserved.
//
import Foundation
import UIKit

//empty array
var archiveList = [DueElement]()//[DueElement(dueName: "CS225 MP", dueDate: time(year: 2017, month: 1, date: 1, hour: 21, minute: 30), createdDate: time(year: 2016, month: 12, date: 30, hour: 10, minute: 00)), DueElement(dueName: "ECON471 HW", dueDate: time(year: 2016, month: 12, date: 31, hour: 21, minute: 30), createdDate: time(year: 2016, month: 12, date: 29, hour: 12, minute: 30)), DueElement(dueName: "IOS Coding", dueDate: time(year: 2017, month: 1, date: 2, hour: 19, minute: 30), createdDate: time(year: 2016, month: 12, date: 30, hour: 21, minute: 30))]


class ArchiveViewController: UIViewController_, UITableViewDelegate, UITableViewDataSource {
    
    @IBAction func BackButton(_ sender: Any) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "LVC")
        //        secondViewController?.transitioningDelegate = self.viewTransitionManager
        //self.view.isHidden = true
        self.present(secondViewController!, animated: true, completion: nil)
    }
   
    @IBOutlet weak var ArchiveListView: UITableView!
    
    //Gesture Control
    //Left to right Edge Pan Gesture
    func createLeftEdgePanGestureRecognizer(targetView: UIView){
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(self.LeftEdgePanHandler(_:)))
        edgePan.edges = .left
        targetView.addGestureRecognizer(edgePan)
    }
    
    func LeftEdgePanHandler(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "LVC")
            self.present(secondViewController!, animated: false, completion: nil)
        }
    }

    
    public func numberOfSections(in tableView: UITableView) -> Int {
        //return 10
        return (archiveList.count)
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section==0{
            return 0
        }
        return 3
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = background_
        return v
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: ArchiveElementCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ArchiveElementCell

        cell.ProgressBar?.progressTintColor = textColor_custom.withAlphaComponent(0.5)
        cell.ProgressBar?.trackTintColor = textColor_custom.withAlphaComponent(0.1)
        cell.ProgressBar?.setProgress(archiveList[indexPath.section].finishProgress!, animated: false)
        
        cell.DueDateLabel?.text = archiveList[indexPath.section].dueMonth_string! + " " + archiveList[indexPath.section].getDueDateText() + ", " + archiveList[indexPath.section].getDueYearText()
        cell.DueNameLabel?.text = archiveList[indexPath.section].dueName
        cell.FinishDateLabel?.text = archiveList[indexPath.section].finishMonth_string! + " " + archiveList[indexPath.section].getFinishDateText() + ", " + archiveList[indexPath.section].getFinishYearText()
        
        
        //add Mclist functionalities
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        cell.selectionStyle = .none
        cell.defaultColor = UIColor(netHex:0xfaf8f8, isLargerAlpha: 1)
        cell.firstTrigger = 0.26;
        cell.secondTrigger = 0.45;
        
        
        //add Listener
        cell.setSwipeGestureWith(UIImageView(image: UIImage(named: "check")!), color: UIColor(netHex:0xf1c40f, isLargerAlpha: 0.7), mode: .none, state: .state1, completionBlock: { (cell, state, mode) -> Void in
        })
        
        cell.setSwipeGestureWith(UIImageView(image: UIImage(named: "check")!), color: UIColor(netHex:0xf1c40f, isLargerAlpha: 0.7), mode: .none, state: .state2, completionBlock: { (cell, state, mode) -> Void in
        })
        
        cell.setSwipeGestureWith(UIImageView(image: UIImage(named: "cross")!), color:  UIColor(netHex:0xf1c40f, isLargerAlpha: 0.7), mode: .exit, state: .state3, completionBlock: { (cell, state, mode) -> Void in
        })
        
        cell.setSwipeGestureWith(UIImageView(image: UIImage(named: "cross")!), color: UIColor(netHex:0xf1c40f, isLargerAlpha: 0.7), mode: .exit, state: .state4, completionBlock: { (cell, state, mode) -> Void in
            //swipe left to insert into dueList; sort through timeleft
            if dueList.isEmpty{
                dueList.insert(archiveList[indexPath.section], at:0)
            }else{
                var insertEnd = true
                for i in 0...dueList.count-1{
                    if(archiveList[indexPath.section].isLessInTimeLeft(element: dueList[i])){                         dueList.insert(archiveList[indexPath.section], at: i)
                        insertEnd = false
                        break
                    }
                }
                if(insertEnd){
                    dueList.append(archiveList[indexPath.section])
                }
            }
            //update completed count
            finishedTaskCount -= 1
            archiveList.remove(at: indexPath.section)//potential bug
            self.ArchiveListView.reloadData()
            
        })
        
        //set rounded corner
        cell.layer.cornerRadius = 7
        cell.layer.masksToBounds = true
        
        //ProgressBar Style
        cell.ProgressBar.layer.cornerRadius = 0.7
        cell.ProgressBar.layer.masksToBounds = true
        cell.ProgressBar.progressViewStyle = .bar
        if (!cell.transformed)
        {
            cell.ProgressBar.transform = cell.ProgressBar.transform.scaledBy(x: 1, y: 7)
            cell.transformed = true
        }
        
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        createLeftEdgePanGestureRecognizer(targetView: self.ArchiveListView)
        createLeftEdgePanGestureRecognizer(targetView: self.view)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
