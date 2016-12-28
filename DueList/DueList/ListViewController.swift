//
//  ViewController.swift
//  DueList
//
//  Created by Derek Wu on 2016/12/24.
//  Copyright © 2016年 Xintong Wu. All rights reserved.
//

import UIKit

//Global Vars
var list = [DueElement(dueName: "CS225 MP", month: 12, date: 28, hour: 21), DueElement(dueName: "ECON471 HW", month: 12, date: 30, hour: 12), DueElement(dueName: "IOS Coding", month: 12, date: 31, hour: 21)]


class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    //Links
    @IBOutlet weak var DueList: UITableView!
    @IBOutlet weak var CountLabel: UILabel!
    
    //Buttons
    @IBAction func ChangeView(_ sender: AnyObject) {
        print("Change View button clicked")
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "IVC") //as! ListViewController
        self.present(secondViewController!, animated: true, completion: nil)
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
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        CountLabel.text = String(list.count)
        return(list.count)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: DueElementCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! DueElementCell
        var progress: Float?
        cell.textLabel?.text = String(indexPath.row+1)
        cell.nameLabel?.text = list[indexPath.row].dueName
        cell.timeLabel?.text = String(list[indexPath.row].timeLeft!) + "Hrs"
        if (list[indexPath.row].color == UIColor.red) {progress = 0.9}
        else if (list[indexPath.row].color == UIColor.yellow) {progress = 0.6}
        else {progress = 0.3}
        cell.progressBar?.progressTintColor = list[indexPath.row].color
        cell.progressBar?.setProgress(progress!, animated: true)
        return(cell)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == UITableViewCellEditingStyle.delete
        {
            list.remove(at: indexPath.row)
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
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(InputViewController.handleSwipes(_:)))
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}

