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
    
    //Functions
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        print("called tableview!")
        CountLabel.text = String(list.count)
        return(list.count)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: DueElementCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! DueElementCell
        cell.textLabel?.text = list[indexPath.row]
        cell.nameLabel?.text = "Homework"
        cell.timeLabel?.text = String(describing: NSDate())
        print("cell")
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
    
    override func viewDidAppear(_ animated: Bool) {
        print("reload!")
        DueList.reloadData()
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

