//
//  ViewController.swift
//  DueList
//
//  Created by Derek Wu on 2016/12/24.
//  Copyright © 2016年 Xintong Wu. All rights reserved.
//

import UIKit
import  UserNotifications
import UserNotificationsUI

    //Global Vars
    var dueList = [DueElement(dueName: "CS225 MP", month: 12, date: 28, hour: 21), DueElement(dueName: "ECON471 HW", month: 12, date: 30, hour: 12), DueElement(dueName: "IOS Coding", month: 12, date: 31, hour: 21)]
    var selectedCellIndexPath_1: IndexPath?//For double tap
//    var selectedCellIndexPath_2: IndexPath?



class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    let requestIdentifier = "SampleRequest"
    
    //Links
    @IBOutlet weak var DueList: UITableView!
    @IBOutlet weak var CountLabel: UILabel!
    
    //Buttons
    @IBAction func ChangeView(_ sender: AnyObject) {
        notify();
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "IVC") //as! ListViewController
        self.present(secondViewController!, animated: true, completion: nil)
    }
    
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
    
    //Functions
    
    /*For swipe down gesture*/
    func handleSwipes(_ sender : UISwipeGestureRecognizer){
        if(sender.direction == .down /*&& sender.location(ofTouch: <#T##Int#>, in: <#T##UIView?#>)*/){

            print("Handling gesture - LVC")
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "IVC")
            self.present(secondViewController!, animated: true, completion: nil)
        }
    }
    

    
    func handleDoubleTap(_ sender : UITapGestureRecognizer){
        let cell = DueList.cellForRow(at: selectedCellIndexPath_1!) as! DueElementCell
        if (cell.dueDateLabel?.isHidden != true)
        {
            cell.dueDateLabel?.isHidden = true
            cell.nameLabel?.isHidden = false;
            cell.timeLabel?.isHidden = false;
        }
        else
        {
            cell.dueDateLabel?.isHidden = false
            cell.nameLabel?.isHidden = true;
            cell.timeLabel?.isHidden = true;
            
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        CountLabel.text = String(dueList.count)
        return(dueList.count)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: DueElementCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! DueElementCell
        var progress: Float?
        cell.dueDateLabel.isHidden = true
        
        //custom progress bar
        cell.progressBar.transform = cell.progressBar.transform.scaledBy(x: 2, y: 35)
        if (dueList[indexPath.row].color == UIColor.red) {progress = 0.9}
        else if (dueList[indexPath.row].color == UIColor.yellow) {progress = 0.6}
        else {progress = 0.3}
        cell.progressBar?.progressTintColor = dueList[indexPath.row].color?.withAlphaComponent(0.5)
        cell.progressBar?.trackTintColor = dueList[indexPath.row].color?.withAlphaComponent(0.1)
        cell.progressBar?.setProgress(progress!, animated: true)
        
        cell.textLabel?.text = String(indexPath.row+1)
        cell.nameLabel?.text = dueList[indexPath.row].dueName
        cell.timeLabel?.text = String(dueList[indexPath.row].timeLeft!) + "Hrs"
        //cell.dueDateLabel.text = String(dueList[selectedCellIndexPath_1!.row].dueDate?.month) + "Months"
        return(cell)
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if (selectedCellIndexPath_1 == -1)
//        {
            selectedCellIndexPath_1 = indexPath
//        }
//        else if (selectedCellIndexPath_2 == -1)
//            selectedCellIndexPath_2 = indexPath
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == UITableViewCellEditingStyle.delete
        {
            dueList.remove(at: indexPath.row)
            DueList.reloadData()
        }
    }
    
    //Override Functions
    override func viewDidAppear(_ animated: Bool) {
        print("reload!")
        DueList.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Gesture control
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTap.numberOfTapsRequired = 2;
        view.addGestureRecognizer(doubleTap)
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//setup notification
extension ListViewController:UNUserNotificationCenterDelegate{
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        print("Tapped in notification")
    }
    
    //This is key callback to present notification while the app is in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print("Notification being triggered")
        //You can either present alert ,sound or increase badge while the app is in foreground too with ios 10
        //to distinguish between notifications
        if notification.request.identifier == requestIdentifier{
            
            completionHandler( [.alert,.sound,.badge])
            
        }
    }
}


