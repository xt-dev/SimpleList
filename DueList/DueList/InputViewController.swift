//
//  InputViewController.swift
//  DueList
//
//  Created by Derek Wu on 2016/12/24.
//  Copyright © 2016年 Xintong Wu. All rights reserved.
//

import Foundation
import UIKit

class InputViewController: UIViewController {
    
    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var dateInput: UIDatePicker!


    func handleSwipes(_ sender : UISwipeGestureRecognizer){
        if(sender.direction == .up){
            print("Handling gesture - IVC")
            if (input.text != "")
            {
                print("add item: " + input.text!)
                //declare a new DueElement object
                let date = dateInput.date
                let cur_dueElement = DueElement(dueName: input.text!, month: dateInput.calendar.component(.month, from: date as Date), date: dateInput.calendar.component(.day, from: date as Date), hour: dateInput.calendar.component(.hour, from: date as Date))
                /*Sort Start*/
                if dueList.isEmpty{
                    dueList.insert(cur_dueElement, at:0)
                }else{
                    var insertEnd = true
                    for i in 0...dueList.count-1{
                        if(cur_dueElement.timeLeft! < dueList[i].timeLeft!){
                            dueList.insert(cur_dueElement, at: i)
                            insertEnd = false
                            break
                        }
                    }
                    if(insertEnd){
                        dueList.append(cur_dueElement)
                    }
                }
                /*Sort End*/
                input.text = ""
            }
            else
            {
                let alertController = UIAlertController(title: "Due List", message:
                    "Invalid input", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                
                self.present(alertController, animated: true, completion: nil)
            }
            
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "LVC")
            self.present(secondViewController!, animated: true, completion: nil)
        }
        else if (sender.direction == .down){
            print("Cancel input")
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "LVC")
            self.present(secondViewController!, animated: true, completion: nil)

        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Checkpoint")

        // Do any additional setup after loading the view, typically from a nib.
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(InputViewController.handleSwipes(_:)))
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(InputViewController.handleSwipes(_:)))
        swipeUp.direction = .up
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)
        view.addGestureRecognizer(swipeUp)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
