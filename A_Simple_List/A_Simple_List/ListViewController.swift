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


var dueList = [DueElement(dueName: "CS225 MP", dueDate: time(year: 2017, month: 1, date: 5, hour: 22, minute: 57), createdDate: time(year: 2016, month: 12, date: 30, hour: 10, minute: 00)), DueElement(dueName: "ECON471 HW", dueDate: time(year: 2017, month: 12, date: 1, hour: 21, minute: 30), createdDate: time(year: 2016, month: 12, date: 29, hour: 12, minute: 30)), DueElement(dueName: "IOS Coding", dueDate: time(year: 2017, month: 1, date: 17, hour: 19, minute: 30), createdDate: time(year: 2016, month: 12, date: 30, hour: 21, minute: 30))]

//set default as nothing
var FocusElement: DueElement? = nil

//var refreshControl: UIRefreshControl!
//var customView: UIView!

class ListViewController: UIViewController_, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBOutlet weak var DueListView: UITableView!

    @IBAction func ListViewButton(_ sender: Any) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "PVC")
        self.present(secondViewController!, animated: true, completion: nil)
    }
    @IBAction func ArchiveViewButton(_ sender: Any) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "AVC")
        secondViewController?.transitioningDelegate = self.viewTransitionManager
        self.present(secondViewController!, animated: true, completion: nil)
            }
    @IBAction func PersonalInfoViewButton(_ sender: Any) {
    }
    
    
    var viewTransitionManager = ViewTransitionManager()
    
    let requestIdentifier = "SampleRequest"//request element
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    //detect shake motion and send alert
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            let alertController = UIAlertController(title: "Hey Nigga", message: "What do you want to do?", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
        }
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
                print(indexPath[1])
                FocusElement = dueList[indexPath[1]]
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
        var progress: Float?
        //custom progress bar
        let cell: DueElementCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! DueElementCell
        progress = 1 - (Float(dueList[indexPath.section].timeLeft!)/Float(dueList[indexPath.section].timeInterval!))
        cell.ProgressBar?.progressTintColor = dueList[indexPath.section].color?.withAlphaComponent(0.5)
        cell.ProgressBar?.trackTintColor = dueList[indexPath.section].color?.withAlphaComponent(0.1)
        cell.ProgressBar?.setProgress(progress!, animated: true)

        //Assign text to label
        cell.DueNameLabel?.text = dueList[indexPath.section].dueName
        cell.DueDateLabel?.text = dueList[indexPath.section].dueMonth_string! + " " + dueList[indexPath.section].getDueDateText() + ", " + dueList[indexPath.section].getDueYearText()
        cell.TimeLeftLabel?.text = String(dueList[indexPath.section].timeLeft!) + "Hrs"
        
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
            dueList[indexPath.section].finishProgress = progress
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
        
        cell.setSwipeGestureWith(UIImageView(image: UIImage(named: "cross")!), color:  UIColor(netHex:0xEC644B, isLargerAlpha: 0.7), mode: .switch, state: .state3, completionBlock: { (cell, state, mode) -> Void in
            
            
        })
        
        cell.setSwipeGestureWith(UIImageView(image: UIImage(named: "cross")!), color: UIColor(netHex:0xEC644B, isLargerAlpha: 0.7), mode: .exit, state: .state4, completionBlock: { (cell, state, mode) -> Void in
            
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

