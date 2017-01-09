//
//  extension.swift
//  Pods
//
//  Created by Derek Wu on 2017/1/7.
//
//

import Foundation
import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, isLargerAlpha: Float) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(isLargerAlpha))
        
    }
    
    convenience init(netHex:Int, isLargerAlpha: Float) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff, isLargerAlpha: isLargerAlpha)
    }
}

//color reference
var green_: UIColor = UIColor.init(netHex: 0x1abc9c, isLargerAlpha: 1)
var yellow_: UIColor = UIColor.init(netHex: 0xf1c40f, isLargerAlpha: 1)
var red_: UIColor = UIColor.init(netHex: 0xec644b, isLargerAlpha: 1)
var grey_: UIColor = UIColor.init(netHex: 0x757478, isLargerAlpha: 1)
var background_: UIColor = UIColor.init(netHex: 0xECF0F1, isLargerAlpha: 1)
