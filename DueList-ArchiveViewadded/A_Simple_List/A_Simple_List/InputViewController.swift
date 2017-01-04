//
//  InputViewController.swift
//  A_Simple_List
//
//  Created by Derek Wu on 2016/12/31.
//  Copyright © 2016年 Xintong Wu. All rights reserved.
//

import Foundation
import UIKit

class InputViewController: UIViewController{
    @IBOutlet weak var InputTextField: UITextField!
    
    //TODO: Handle swipe with larger area
    
    func handleSwipes(_ sender : UISwipeGestureRecognizer){
        if(sender.direction == .up){
            print("check!")
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "LVC")
            self.present(secondViewController!, animated: false, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    //Draw the bottom line for the textfield
    override func viewDidLayoutSubviews() {
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.init(netHex:0x9B9B9B, isLargerAlpha: 0.7).cgColor
        border.frame = CGRect(x: 0, y: InputTextField.frame.size.height - width, width:  InputTextField.frame.size.width, height: InputTextField.frame.size.height)
        
        border.borderWidth = width
        InputTextField.layer.addSublayer(border)
        InputTextField.layer.masksToBounds = true
    }
    
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

}
