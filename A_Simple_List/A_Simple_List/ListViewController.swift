//
//  ViewController.swift
//  A_Simple_List
//
//  Created by Derek Wu on 2016/12/31.
//  Copyright © 2016年 Xintong Wu. All rights reserved.
//

import UIKit
import Foundation
import UserNotifications
import UserNotificationsUI


var dueList = [DueElement(dueName: "CS225 MP", dueDate: time(year: 2017, month: 1, date: 9, hour: 14, minute: 50), createdDate: time(year: 2016, month: 12, date: 30, hour: 10, minute: 00)), DueElement(dueName: "ECON471 HW", dueDate: time(year: 2017, month: 12, date: 1, hour: 21, minute: 30), createdDate: time(year: 2016, month: 12, date: 29, hour: 12, minute: 30)), DueElement(dueName: "IOS Coding", dueDate: time(year: 2017, month: 1, date: 17, hour: 19, minute: 30), createdDate: time(year: 2016, month: 12, date: 30, hour: 21, minute: 30))]

//set default as nothing
var FocusElement: DueElement? = nil

//var refreshControl: UIRefreshControl!
//var customView: UIView!

class ListViewController: UIViewController_, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var DueListView: UITableView!
    @IBOutlet weak var statusBar: UILabel!

    @IBAction func PersonalViewButton(_ sender: Any) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "PVC")
        self.present(secondViewController!, animated: false, completion: nil)
    }
    @IBAction func ListViewButton(_ sender: Any) {
        
    }
    @IBAction func ArchiveViewButton(_ sender: Any) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "AVC")
        self.present(secondViewController!, animated: false, completion: nil)
    }

    
    var count:Int = 0
    
    func refreshStatusBar(){
        
        refresh()
        _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(refresh), userInfo: nil, repeats: true)
    }
    
    func refresh(){
        
        UIView.transition(with: statusBar, duration: 1, options: [.transitionCrossDissolve], animations: {self.count += 1
            let hour = getCurrentTimeComponents().hour
            let minute = getCurrentTimeComponents().minute
            var minString = ""
            var hrString = ""
            if (self.count > 5 && self.count <= 10){
                self.statusBar.text = String(dueList.count) + " dues left"
                if (self.count == 10) {self.count = 0}}
            else{
                if (hour! < 10) {hrString = "0" + String(hour!)}
                else {hrString = String(hour!)}
                if (minute! < 10) {minString = "0" + String(minute!)}
                else {minString = String(minute!)}
                self.statusBar.text = hrString + ":" + minString
            }}, completion: nil)
    }
    
    var viewTransitionManager = ViewTransitionManager()
    
    let requestIdentifier = "SampleRequest"//request element
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    //notification setup
    func notify(){
        print("Change View button clicked")
        print("notification will be triggered in five seconds..Hold on tight")
        let content = UNMutableNotificationContent()
        content.title = "Intro to Notifications"
        content.subtitle = "Lets code,Talk is cheap"
        content.body = "Sample code from WWDC"
        content.sound = UNNotificationSound.default()
        
        //To Present image in notification
        if let path = Bundle.main.path(forResource: "monkey", ofType: "png") {
            let url = URL(fileURLWithPath: path)
            
            do {
                let attachment = try UNNotificationAttachment(identifier: "sampleImage", url: url, options: nil)
                content.attachments = [attachment]
            } catch {
                print("attachment not found.")
            }
        }
        
        // Deliver the notification in five seconds.
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 5.0, repeats: false)
        let request = UNNotificationRequest(identifier:requestIdentifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().add(request){(error) in
            if (error != nil){
                
                print(error?.localizedDescription)
            }
        }
    }
    
    /*=================Gestures Control=================*/
    //Left to right Edge Pan Gesture
    func createLeftEdgePanGestureRecognizer(targetView: UIView){
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(self.LeftEdgePanHandler(_:)))
        edgePan.edges = .left
        targetView.addGestureRecognizer(edgePan)
    }
    
    func LeftEdgePanHandler(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "PVC")
            self.present(secondViewController!, animated: false, completion: nil)
        }
    }
    //Right to left Edge Pan Gesture
    func createRightEdgePanGestureRecognizer(targetView: UIView){
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(self.RightEdgePanHandler(_:)))
        edgePan.edges = .right
        targetView.addGestureRecognizer(edgePan)
    }
    func RightEdgePanHandler(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "AVC")
            self.present(secondViewController!, animated: false, completion: nil)
        }
    }
    
    //Pan Gesture
    func createPanGestureRecognizer(targetView: UIView){
        let panGesture = UIPanGestureRecognizer(target: self, action:#selector(self.handlePanGesture(panGesture:)))
        panGesture.delegate = self
        targetView.addGestureRecognizer(panGesture)
    }
    //Pan Gesture Recognizer
    func handlePanGesture(panGesture: UIPanGestureRecognizer) {
        //get translation
        let translation = panGesture.translation(in: view)
        let zero: CGPoint = CGPoint(x: 0, y: 0)
        panGesture.setTranslation(zero, in: view)
        let y_loc:CGFloat? = translation.y
        let ref : CGFloat? = 80
        if (DueListView.contentOffset.y <= 0)
        {
            //print(translation.y)
            if (y_loc! > ref!)
            {
                //print(">80")
                let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "IVC")
                secondViewController?.transitioningDelegate = self.viewTransitionManager
                self.present(secondViewController!, animated: true, completion: nil)
            }
        }
    }
    
    //Long Press Gesture Constructor
    func createLongPressGestureRecognizer(targetView: UIView)
    {
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.longPress(_:)))
        targetView.addGestureRecognizer(longPressRecognizer)
    }
    //Long press Gesture Handler
    func longPress(_ sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.began {
            let touchPoint = sender.location(in: self.DueListView)
            if let indexPath = DueListView.indexPathForRow(at: touchPoint) {
                FocusElement = dueList[indexPath[0]]
                let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "FVC")
                self.present(secondViewController!, animated: false, completion: nil)
            }
        }
    }
    
    //Swipe Gesture constructor
    func createSwipeDownGestureRecognizer(targetView: UIView)
    {
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipes(_:)))
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)
    }
    //Swipe Gestures Handler
    func handleSwipes(_ sender : UISwipeGestureRecognizer){
        if(sender.direction == .down /*&& sender.location(ofTouch: <#T##Int#>, in: <#T##UIView?#>)*/){
            print("check!")
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "IVC")
            //secondViewController?.transitioningDelegate = self.viewTransitionManager
            self.present(secondViewController!, animated: false, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //notify(); //called notify function
        let InputViewController = segue.destination as! InputViewController
        InputViewController.transitioningDelegate = self.viewTransitionManager
    }
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        //let sourceController = segue.source as! InputViewController
    }
    
    //custom section header size
    public func numberOfSections(in tableView: UITableView) -> Int {
        //return 10
        return (dueList.count)
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
//        var progress = dueList[indexPath.section
        //custom progress bar
        let cell: DueElementCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! DueElementCell
        dueList[indexPath.section].finishProgress = 1 - (Float(dueList[indexPath.section].timeLeftInSec!)/Float(dueList[indexPath.section].timeInterval!))
        cell.ProgressBar?.progressTintColor = dueList[indexPath.section].color?.withAlphaComponent(0.5)
        cell.ProgressBar?.trackTintColor = dueList[indexPath.section].color?.withAlphaComponent(0.1)
        cell.ProgressBar?.setProgress(dueList[indexPath.section].finishProgress!, animated: false)
        
        print("setProgess")
        //Assign text to label
        cell.DueNameLabel?.text = dueList[indexPath.section].dueName
        cell.DueDateLabel?.text = dueList[indexPath.section].dueMonth_string! + " " + dueList[indexPath.section].getDueDateText() + ", " + dueList[indexPath.section].getDueYearText()
        if (dueList[indexPath.section].color == green_){
            cell.TimeLeftLabel?.text = String(Int((dueList[indexPath.section].timeLeft!)/24)) + " Days"
        }
        else if (dueList[indexPath.section].color == yellow_){
            cell.TimeLeftLabel?.text = String(dueList[indexPath.section].timeLeft!) + " Hrs"
        }
        else if (dueList[indexPath.section].timeLeftInMin! <= 0){
            cell.TimeLeftLabel?.text = "0 Min"
        }
        else{//(dueList[indexPath.section].timeLeft! <= 0 && dueList[indexPath.section].timeLeftInMin! > 0){
            cell.TimeLeftLabel?.text = String(dueList[indexPath.section].timeLeftInMin!) + " Mins"
        }
//        else{
//            cell.TimeLeftLabel?.text = String(dueList[indexPath.section].timeLeft!) + " Hrs " + String(dueList[indexPath.section].timeLeftInMin! - dueList[indexPath.section].timeLeft!*60) + " Mins "
//        }
        
        //add Mclist functionalities
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        cell.selectionStyle = .none
        cell.defaultColor = UIColor(netHex:0xfaf8f8, isLargerAlpha: 1)
        cell.firstTrigger = 0.25;
        cell.secondTrigger = 0.45;
        
        //add Listener
        cell.setSwipeGestureWith(UIImageView(image: check_use), color: UIColor(netHex:0x1ABC9C, isLargerAlpha: 0.7), mode: .switch, state: .state1, completionBlock: { (cell, state, mode) -> Void in
        })
        
        cell.setSwipeGestureWith(UIImageView(image: check_use), color: UIColor(netHex:0x1ABC9C, isLargerAlpha: 0.7), mode: .exit, state: .state2, completionBlock: { (cell, state, mode) -> Void in
            
            //register finishDate
            let date = NSDate()
            let calender = NSCalendar.current
            let month = calender.component(.month, from: date as Date)
            let day = calender.component(.day, from: date as Date)
            let year = calender.component(.year, from: date as Date)
            dueList[indexPath.section].finishDate = time(year: year, month: month, date: day, hour: nil, minute: nil)
            switch month {
            case 1:
                dueList[indexPath.section].finishMonth_string = "Jan"
            case 2:
                dueList[indexPath.section].finishMonth_string = "Feb"
            case 3:
                dueList[indexPath.section].finishMonth_string = "Mar"
            case 4:
                dueList[indexPath.section].finishMonth_string = "Apr"
            case 5:
                dueList[indexPath.section].finishMonth_string = "May"
            case 6:
                dueList[indexPath.section].finishMonth_string = "Jun"
            case 7:
                dueList[indexPath.section].finishMonth_string = "Jul"
            case 8:
                dueList[indexPath.section].finishMonth_string = "Aug"
            case 9:
                dueList[indexPath.section].finishMonth_string = "Sep"
            case 10:
                dueList[indexPath.section].finishMonth_string = "Oct"
            case 11:
                dueList[indexPath.section].finishMonth_string = "Nov"
            case 12:
                dueList[indexPath.section].finishMonth_string = "Dec"
            default:
                dueList[indexPath.section].finishMonth_string = "invalid"
            }
            dueList[indexPath.section].isFinished = true
            //swipe right to insert into archiveList; sort through finishDate
            if archiveList.isEmpty{
                archiveList.insert(dueList[indexPath.section], at:0)
            }else{
                var insertEnd = true
                for i in 0...archiveList.count-1{
                    if(dueList[indexPath.section].isLessInFinishDate(element: archiveList[i])){
                        archiveList.insert(dueList[indexPath.section], at: i)
                        insertEnd = false
                        break
                    }
                }
                if(insertEnd){
                    archiveList.append(dueList[indexPath.section])
                }
            }
            
            //update complete
            finishedTaskCount += 1
            
            dueList.remove(at: indexPath.section)//potential bug
            self.DueListView.reloadData()
        })
        

        cell.setSwipeGestureWith(UIImageView(image: cross_use), color:  UIColor(netHex:0xEC644B, isLargerAlpha: 0.7), mode: .switch, state: .state3, completionBlock: { (cell, state, mode) -> Void in
        })
        
        cell.setSwipeGestureWith(UIImageView(image: cross_use), color: UIColor(netHex:0xEC644B, isLargerAlpha: 0.7), mode: .exit, state: .state4, completionBlock: { (cell, state, mode) -> Void in
            dueList.remove(at: indexPath.section)//potential bug
            self.DueListView.reloadData()
            
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
        
        return(cell)
    }

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //refresh status bar
        refreshStatusBar()
        
        //Pull Down Pan Gesture
        createPanGestureRecognizer(targetView: self.DueListView)
        //Long Press Gesture
        createLongPressGestureRecognizer(targetView: self.DueListView)
        //Edge Pan Gesture
        createLeftEdgePanGestureRecognizer(targetView: self.DueListView)
        createRightEdgePanGestureRecognizer(targetView: self.DueListView)
        createLeftEdgePanGestureRecognizer(targetView: self.view)
        createRightEdgePanGestureRecognizer(targetView: self.view)
        
        //disable scroll if tableview is not full
        if (DueListView.contentSize.height < DueListView.frame.size.height) {
            DueListView.isScrollEnabled = false;
        }
        else {
            DueListView.isScrollEnabled = true;
        }
        
        //refresh the list
        Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(updateList), userInfo: nil, repeats: true)
    }
    
    func updateList(){
        print("udateList!")
        if (dueList.isEmpty == false){
            var count_temp = dueList.count
            var i = 0
//            var indexPath = NSIndexPath(row: i, section: 0)
            while (i < count_temp){
                dueList[i].refreshData()//refresh data
                print("list :\(i), insec :\(dueList[i].timeLeftInSec!)")
                dueList[i].finishProgress = 1 - (Float(dueList[i].timeLeftInSec!)/Float(dueList[i].timeInterval!))
                print("update to progress:\(dueList[i].finishProgress)")
                if (dueList[i].timeLeftInSec! <= 0){
                    let components = getCurrentTimeComponents()
                    dueList[i].finishDate = time(year: components.year, month: components.month, date: components.day, hour: components.hour, minute: components.minute)
                    dueList[i].isFinished = false//mark as not finished
                    dueList[i].monthStringInput(month: components.month!)
                    //insert into archiveList; sort through finishDate
                    if archiveList.isEmpty{
                        archiveList.insert(dueList[i], at:0)
                    }else{
                        var insertEnd = true
                        for j in 0...archiveList.count-1{
                            if(dueList[i].isLessInFinishDate(element: archiveList[j])){
                                archiveList.insert(dueList[i], at: j)
                                insertEnd = false
                                break
                            }
                        }
                        if(insertEnd){
                            archiveList.append(dueList[i])
                        }
                    }
                    print(i)
                    dueList.remove(at: i)
                    count_temp -= 1
                }
                if (dueList[i].postNotify_y == false){
                    
                }
                i += 1
            }
            print("update!")
            DueListView.reloadData()
//            self.refresh()
        }
    }

    //notification
    func notify(element : DueElement){
        let content = UNMutableNotificationContent()
        if(element.color == yellow_){
            content.title = "Intro to Notifications"
            content.subtitle = "progress bar is yellow"
            content.body = "Sample code from WWDC"
            content.sound = UNNotificationSound.default()
        }else if(element.color == red_){
            content.title = "Intro to Notifications"
            content.subtitle = "progress bar is red"
            content.body = "Sample code from WWDC"
            content.sound = UNNotificationSound.default()
        }
        
        //To Present image in notification
        if let path = Bundle.main.path(forResource: "monkey", ofType: "png") {
            let url = URL(fileURLWithPath: path)
            
            do {
                let attachment = try UNNotificationAttachment(identifier: "sampleImage", url: url, options: nil)
                content.attachments = [attachment]
            } catch {
                print("attachment not found.")
            }
        }
        
        // Deliver the notification in five seconds.
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 1.0, repeats: false)
        let request = UNNotificationRequest(identifier:requestIdentifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().add(request){(error) in
            if (error != nil){
                
                print(error?.localizedDescription)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//Disabled

// Custom Refresh Content
//    func loadCustomRefreshContents() {
//        let refreshContents = Bundle.main.loadNibNamed("InputViewController", owner: self, options: nil)
//customView = refreshContents?[0] as! UIView
//        customView = DueListView.backgroundView
//        customView.frame = refreshControl.bounds
//        refreshControl.addSubview(customView)
//    }

//Refresh control
//        refreshControl = UIRefreshControl()
//        refreshControl.
//        DueListView.addSubview(refreshControl)
//        if (refreshControl.isRefreshing == true)
//        {
//            print("refresh")
//        }
//        loadCustomRefreshContents()

