//
//  InputViewController.swift
//  A_Simple_List
//
//  Created by Derek Wu on 2016/12/31.
//  Copyright © 2016年 Xintong Wu. All rights reserved.
//

import Foundation
import UIKit

let Example_dueDate = time(year: 2017, month: 1, date: 7, hour: 3, minute: 19)
let Example_create = time(year: 2017, month: 1, date: 5, hour: 8, minute: 12)

class InputViewController: UIViewController{
    
    //Links
    @IBOutlet weak var InputTextField: UITextField!
    
    
    //Handle swipe gesture
    func handleSwipes(_ sender : UISwipeGestureRecognizer){
        if(sender.direction == .up){
            print("Handling gesture - IVC")
            if (InputTextField.text != "")
            {
                print("add item: " + InputTextField.text!)
                //declare a new DueElement object
                let cur_dueElement = DueElement(dueName: InputTextField.text!, dueDate: Example_dueDate, createdDate: Example_create)
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
                InputTextField.text = ""
            }
            //invalid input notification
//            else
//            {
//                let alertController = UIAlertController(title: "Due List", message:
//                    "Invalid input", preferredStyle: UIAlertControllerStyle.alert)
//                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
//                
//                self.present(alertController, animated: true, completion: nil)
//            }

            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "LVC")
            self.present(secondViewController!, animated: false, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    //Draw the bottom line for the textfield
    //    override func viewDidLayoutSubviews() {
    //        let border = CALayer()
    //        let width = CGFloat(2.0)
    //        border.borderColor = UIColor.init(netHex:0x9B9B9B, isLargerAlpha: 0.7).cgColor
    //        border.frame = CGRect(x: 0, y: InputTextField.frame.size.height - width, width:  InputTextField.frame.size.width, height: InputTextField.frame.size.height)
    //        
    //        border.borderWidth = width
    //        InputTextField.layer.addSublayer(border)
    //        InputTextField.layer.masksToBounds = true
    //    }
    //
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Checkpoint")
        // Do any additional setup after loading the view, typically from a nib.
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipes(_:)))
        swipeUp.direction = .up
        view.addGestureRecognizer(swipeUp)
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //hide keyboard when user touch outside area of the keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }
//    //hide when press return
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        InputTextField.resignFirstResponder()
//        return true
//    }
    
}
