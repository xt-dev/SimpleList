//
//  ViewController.swift
//  A_Simple_List
//
//  Created by Derek Wu on 2016/12/31.
//  Copyright © 2016年 Xintong Wu. All rights reserved.
//

import UIKit
import Foundation


var dueList = [DueElement(dueName: "CS225 MP", dueDate: time(year: 2017, month: 1, date: 1, hour: 21, minute: 30), createdDate: time(year: 2016, month: 12, date: 30, hour: 10, minute: 00)), DueElement(dueName: "ECON471 HW", dueDate: time(year: 2016, month: 12, date: 31, hour: 21, minute: 30), createdDate: time(year: 2016, month: 12, date: 29, hour: 12, minute: 30)), DueElement(dueName: "IOS Coding", dueDate: time(year: 2017, month: 1, date: 2, hour: 19, minute: 30), createdDate: time(year: 2016, month: 12, date: 30, hour: 21, minute: 30))]

//var refreshControl: UIRefreshControl!
//var customView: UIView!



class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var DueListView: UITableView!

    @IBAction func ListViewButton(_ sender: Any) {
    }
    @IBAction func ArchiveViewButton(_ sender: Any) {
    }
    @IBAction func PersonalInfoViewButton(_ sender: Any) {
    }
    
    var viewTransitionManager = ViewTransitionManager()
    
    
//TODO: Try to use refreshcontent to triger IPV
    
//    func loadCustomRefreshContents() {
//        let refreshContents = Bundle.main.loadNibNamed("InputView", owner: self, options: nil)
//        customView = refreshContents?[0] as! UIView
//        customView.frame = refreshControl.bounds
//        refreshControl.addSubview(customView)
//    }
    
    func handleSwipes(_ sender : UISwipeGestureRecognizer){
        if(sender.direction == .down /*&& sender.location(ofTouch: <#T##Int#>, in: <#T##UIView?#>)*/){
            print("check!")
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "IVC")
            //secondViewController?.transitioningDelegate = self.viewTransitionManager
            self.present(secondViewController!, animated: false, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let InputViewController = segue.destination as! InputViewController
        InputViewController.transitioningDelegate = self.viewTransitionManager
    }
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        //let sourceController = segue.source as! InputViewController
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        print("called tableview!")
        return(dueList.count)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var progress: Float?
        //custom progress bar
        let cell: DueElementCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! DueElementCell

        progress = 1-(Float(dueList[indexPath.row].timeLeft!)/Float(dueList[indexPath.row].timeInterval!))
        cell.ProgressBar?.progressTintColor = dueList[indexPath.row].color?.withAlphaComponent(0.5)
        cell.ProgressBar?.trackTintColor = dueList[indexPath.row].color?.withAlphaComponent(0.1)
        cell.ProgressBar?.setProgress(progress!, animated: true)
        
        cell.DueNameLabel?.text = dueList[indexPath.row].dueName
        cell.DueDateLabel?.text = String(dueList[indexPath.row].timeLeft!) + "Hrs"
        
        //add Mclist functionalities
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        cell.selectionStyle = .none
        cell.defaultColor = UIColor(netHex:0x1ABC9C, isLargerAlpha: false)
        cell.firstTrigger = 0.25;
        cell.secondTrigger = 0.50;
        
        
        //add Listener
        cell.setSwipeGestureWith(UIImageView(image: UIImage(named: "check")!), color: UIColor(netHex:0x1ABC9C, isLargerAlpha: true), mode: .exit, state: .state1, completionBlock: { (cell, state, mode) -> Void in
            
            dueList.remove(at: indexPath.row)
            self.DueListView.reloadData()
            
        })
        cell.setSwipeGestureWith(UIImageView(image: UIImage(named: "cross")!), color:  UIColor(netHex:0xEC644B, isLargerAlpha: true), mode: .exit, state: .state3, completionBlock: { (cell, state, mode) -> Void in
            dueList.remove(at: indexPath.row)
            self.DueListView.reloadData()
        })

        
        return(cell)
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipes(_:)))
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)
        DueListView.addGestureRecognizer(swipeDown)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, isLargerAlpha: Bool) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        if(isLargerAlpha==true){
            self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 0.9)
        }else{
            self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 0.7)
        }
    }
    
    convenience init(netHex:Int, isLargerAlpha: Bool) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff, isLargerAlpha: isLargerAlpha)
    }
}

