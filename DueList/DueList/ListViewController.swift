//
//  ViewController.swift
//  DueList
//
//  Created by Derek Wu on 2016/12/24.
//  Copyright © 2016年 Xintong Wu. All rights reserved.
//

import UIKit

//Global Vars
var list = ["1", "2", "3"]

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
            //animationstart = true
            print("Handling gesture - LVC")
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "IVC")
            self.present(secondViewController!, animated: true, completion: nil)
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
//        print("called tableview!")
        CountLabel.text = String(list.count)
        return(list.count)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: DueElementCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! DueElementCell
        cell.textLabel?.text = list[indexPath.row]
        cell.nameLabel?.text = "Homework"
        cell.timeLabel?.text = String(describing: NSDate())
        //print("cell")
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
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(InputViewController.handleSwipes(_:)))
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(InputViewController.handleSwipes(_:)))
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}

