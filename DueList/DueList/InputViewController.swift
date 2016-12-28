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
    
    
    //var animationstart = false

    func handleSwipes(_ sender : UISwipeGestureRecognizer){
        if(sender.direction == .up){
            //animationstart = true
            print("Handling gesture - IVC")
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "LVC")
            self.present(secondViewController!, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Checkpoint")

        // Do any additional setup after loading the view, typically from a nib.
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(InputViewController.handleSwipes(_:)))
        swipeUp.direction = .up
        view.addGestureRecognizer(swipeUp)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
