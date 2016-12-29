//
//  ViewController.swift
//  DueList
//
//  Created by Derek Wu on 2016/12/24.
//  Copyright © 2016年 Xintong Wu. All rights reserved.
//

import UIKit

var list = [DueElement(dueName: "CS225 MP", month: 12, date: 28, hour: 21), DueElement(dueName: "ECON471 HW", month: 12, date: 30, hour: 12), DueElement(dueName: "IOS Coding", month: 12, date: 31, hour: 21)]
    //Global Vars

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
        var progress: Float?
        cell.progressBar.transform = cell.progressBar.transform.scaledBy(x: 2, y: 35)

        
        if (list[indexPath.row].color == UIColor.red) {progress = 0.9}
        else if (list[indexPath.row].color == UIColor.yellow) {progress = 0.6}
        else {progress = 0.3}
        cell.progressBar?.progressTintColor = list[indexPath.row].color?.withAlphaComponent(0.5)
        cell.progressBar?.trackTintColor = list[indexPath.row].color?.withAlphaComponent(0.1)
    
        cell.progressBar?.setProgress(progress!, animated: true)
        cell.textLabel?.text = String(indexPath.row+1)
        cell.nameLabel?.text = list[indexPath.row].dueName
        cell.timeLabel?.text = String(list[indexPath.row].timeLeft!) + "Hrs"
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

