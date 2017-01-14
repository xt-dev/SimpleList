//
//  UIViewController_.swift
//  A_Simple_List
//
//  Created by Derek Wu on 2017/1/4.
//  Copyright © 2017年 Xintong Wu. All rights reserved.
//

import Foundation
import UIKit

class UIViewController_ : UIViewController{
    //hide status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
//    func shouldAutorotate() -> Bool {
//        return false
//    }
//    
//    func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
//        return UIInterfaceOrientationMask.portrait
//    }
    func navigationControllerSupportedInterfaceOrientations(navigationController: UINavigationController) -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
}
