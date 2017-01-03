//
//  ArchiveViewController.swift
//  A_Simple_List
//
//  Created by Derek Wu on 2017/1/3.
//  Copyright © 2017年 Xintong Wu. All rights reserved.
//

import Foundation
import UIKit

class ArchiveViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var ArchiveListView: UITableView!

    //TODO: Create a new list and replace the "dueList"
    //Put labels into prototype cell and link them in a new file called "ArchiveElementCell.swift", replace DueElementCell in the file
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        print("called tableview!")
        return(/*dueList*/.count)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        //custom progress bar
        let cell: /*DueElementCell*/ = tableView.dequeueReusableCell(withIdentifier: "cell") as! /*DueElementCell*/
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
