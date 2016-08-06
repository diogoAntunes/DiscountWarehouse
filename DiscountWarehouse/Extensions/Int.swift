//
//  Int.swift
//  DiscountWarehouse
//
//  Created by Diogo Antunes on 8/5/16.
//  Copyright © 2016 Diogo. All rights reserved.
//

import Foundation

extension Int {
    
    var toLocalCurrency: String {
        let numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = .CurrencyStyle
        numberFormatter.maximumFractionDigits = 2
        
        return numberFormatter.stringFromNumber(self)!
    }
    
}