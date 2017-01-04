//
//  ArchiveViewController.swift
//  A_Simple_List
//
//  Created by Derek Wu on 2017/1/3.
//  Copyright © 2017年 Xintong Wu. All rights reserved.
//
import Foundation
import UIKit

var archiveList = //[DueElement(dueName: "CS225 MP", dueDate: time(year: 2017, month: 1, date: 1, hour: 21, minute: 30), createdDate: time(year: 2016, month: 12, date: 30, hour: 10, minute: 00)), DueElement(dueName: "ECON471 HW", dueDate: time(year: 2016, month: 12, date: 31, hour: 21, minute: 30), createdDate: time(year: 2016, month: 12, date: 29, hour: 12, minute: 30)), DueElement(dueName: "IOS Coding", dueDate: time(year: 2017, month: 1, date: 2, hour: 19, minute: 30), createdDate: time(year: 2016, month: 12, date: 30, hour: 21, minute: 30))]
    [DueElement]()

class ArchiveViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBAction func BackButton(_ sender: Any) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "LVC")
        //        secondViewController?.transitioningDelegate = self.viewTransitionManager
        //self.view.isHidden = true
        self.present(secondViewController!, animated: true, completion: nil)
    }
   
    @IBOutlet weak var ArchiveListView: UITableView!
    
    
    //TODO: Create a new list and replace the "dueList"
    //Put labels into prototype cell and link them in a new file called "ArchiveElementCell.swift", replace DueElementCell in the file
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        print("called tableview!")
        return(archiveList.count)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var progress:Float
        let cell: ArchiveElementCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ArchiveElementCell
        
        progress = 1-(Float(archiveList[indexPath.row].timeLeft!)/Float(archiveList[indexPath.row].timeInterval!))
        cell.ProgressBar?.progressTintColor = archiveList[indexPath.row].color?.withAlphaComponent(0.5)
        cell.ProgressBar?.trackTintColor = archiveList[indexPath.row].color?.withAlphaComponent(0.1)
        cell.ProgressBar?.setProgress(progress, animated: true)
        
        cell.DueNameLabel?.text = archiveList[indexPath.row].dueName
        cell.DueDateLabel?.text = String(describing: archiveList[indexPath.row].dueDate?.year)+"/"+String(describing: archiveList[indexPath.row].dueDate?.month)+"/"+String(describing: archiveList[indexPath.row].dueDate?.date)
        
        //add Mclist functionalities
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        cell.selectionStyle = .none
        cell.defaultColor = UIColor(netHex:0xfaf8f8, isLargerAlpha: 1)
        cell.firstTrigger = 0.25;
        cell.secondTrigger = 0.45;
        
        
        //add Listener
        cell.setSwipeGestureWith(UIImageView(image: UIImage(named: "check")!), color: UIColor(netHex:0x1ABC9C, isLargerAlpha: 0.7), mode: .switch, state: .state1, completionBlock: { (cell, state, mode) -> Void in
        })
        
        cell.setSwipeGestureWith(UIImageView(image: UIImage(named: "check")!), color: UIColor(netHex:0x1ABC9C, isLargerAlpha: 0.7), mode: .exit, state: .state2, completionBlock: { (cell, state, mode) -> Void in
            
            dueList.remove(at: indexPath.row)//potential bug
            self.ArchiveListView.reloadData()
        })
        
        cell.setSwipeGestureWith(UIImageView(image: UIImage(named: "cross")!), color:  UIColor(netHex:0xEC644B, isLargerAlpha: 0.7), mode: .switch, state: .state3, completionBlock: { (cell, state, mode) -> Void in
            
            
        })
        
        cell.setSwipeGestureWith(UIImageView(image: UIImage(named: "cross")!), color: UIColor(netHex:0xEC644B, isLargerAlpha: 0.7), mode: .exit, state: .state4, completionBlock: { (cell, state, mode) -> Void in
            //swipe left to insert into dueList; sort through timeleft
            if dueList.isEmpty{
                dueList.insert(archiveList[indexPath.row], at:0)
            }else{
                var insertEnd = true
                for i in 0...dueList.count-1{
                    if(archiveList[indexPath.row].isLessInTimeLeft(element: dueList[i])){
                        dueList.insert(archiveList[indexPath.row], at: i)
                        insertEnd = false
                        break
                    }
                }
                if(insertEnd){
                    dueList.append(archiveList[indexPath.row])
                }
            }
            
            archiveList.remove(at: indexPath.row)//potential bug
            self.ArchiveListView.reloadData()
            
        })
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
