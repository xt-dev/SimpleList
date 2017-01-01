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
    
    //TODO: Handle swipe with larger area
    
    func handleSwipes(_ sender : UISwipeGestureRecognizer){
        if(sender.direction == .up){
            print("check!")
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "LVC")
            self.present(secondViewController!, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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
