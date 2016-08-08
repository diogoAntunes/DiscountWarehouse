//
//  SearchResult.swift
//  DiscountWarehouse
//
//  Created by Diogo Antunes on 8/1/16.
//  Copyright © 2016 Diogo. All rights reserved.
//

import SwiftyJSON

/**
 Example of a Search Result:

 {"type":"face","id":"0-4itmqrfkz6e9izfr","size":24,"price":379,"face":"( .-. )","stock":7,"tags":["flat","bored"]}
 */

struct SearchResult {
    
    enum API: String { case type, id, size, price, face, stock, tags }
    
    let type: String
    let id: String
    let size: Int
    let price: Int
    let face: String
    let stock: Int
    let tags: [String]
}

extension SearchResult {
    
    init(data: JSON) {
        type = data[API.type.rawValue].stringValue
        id = data[API.id.rawValue].stringValue
        size = data[API.size.rawValue].intValue
        price = data[API.price.rawValue].intValue
        face = data[API.face.rawValue].stringValue
        stock = data[API.stock.rawValue].intValue
        
        tags = data[API.tags.rawValue].arrayValue.map({ $0.stringValue })
    }
    
    func getTags() -> String {
        var customTags = ""
        tags.forEach() {
            customTags = customTags.stringByAppendingString("\($0)\n")
        }
        return customTags
    }
}