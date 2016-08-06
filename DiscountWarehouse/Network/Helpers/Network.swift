//
//  Network.swift
//  DiscountWarehouse
//
//  Created by Diogo Antunes on 8/1/16.
//  Copyright © 2016 Diogo. All rights reserved.
//

protocol Network { }

extension Network {
    
    var Network: NetworkProtocol {
        return NetworkManager.sharedInstance
    }
}
