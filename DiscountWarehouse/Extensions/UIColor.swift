//
//  UIColor.swift
//  DiscountWarehouse
//
//  Created by Diogo Antunes on 08/08/16.
//  Copyright © 2016 Diogo. All rights reserved.
//

import UIKit

extension UIColor {
    
    enum Colors: Int {
        case Red = 0xEA524B
        case Green = 0x79D2B1
        case Gray = 0x949CA8
    }
    
    convenience public init(hex: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue = CGFloat((hex & 0xFF)) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    convenience init(color: Colors) {
        self.init(hex: color.rawValue)
    }
}