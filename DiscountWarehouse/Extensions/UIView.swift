//
//  UIButton.swift
//  DiscountWarehouse
//
//  Created by Diogo Antunes on 08/08/16.
//  Copyright © 2016 Diogo. All rights reserved.
//

import UIKit

extension UIView {
    
    func redSquareStyle() {
        layer.borderWidth = 1
        layer.borderColor = UIColor(color: .Red).CGColor
        layer.cornerRadius = 4
        backgroundColor = UIColor(color: .Red)
    }
    
    func graySquareBorder() {
        layer.borderWidth = 1
        layer.cornerRadius = 4
        layer.borderColor = UIColor(color: .Gray).CGColor
    }
}