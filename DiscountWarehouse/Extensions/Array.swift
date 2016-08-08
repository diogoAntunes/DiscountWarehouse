//
//  Array.swift
//  DiscountWarehouse
//
//  Created by Diogo Antunes on 08/08/16.
//  Copyright © 2016 Diogo. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()
        
        for value in self {
            if result.contains(value) == false { result.append(value) }
        }
        
        return result
    }
}