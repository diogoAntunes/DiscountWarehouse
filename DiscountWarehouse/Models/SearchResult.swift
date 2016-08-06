//
//  SearchResult.swift
//  DiscountWarehouse
//
//  Created by Diogo Antunes on 8/1/16.
//  Copyright © 2016 Diogo. All rights reserved.
//

import SwiftyJSON
import RealmSwift

/**
 Example of a Search Result:

 {"type":"face","id":"0-4itmqrfkz6e9izfr","size":24,"price":379,"face":"( .-. )","stock":7,"tags":["flat","bored"]}
 */

class StringObject: Object {
	dynamic var value = ""

	convenience init(stringValue: String) {
		self.init()
		self.value = stringValue
	}
}

class SearchResult: Object {

	enum API: String { case type, id, size, price, face, stock, tags }

	dynamic var type = ""
	dynamic var id = ""
	dynamic var size = 0
	dynamic var price = 0
	dynamic var face = ""
	dynamic var stock = 0
	let tags = List<StringObject>()
}

extension SearchResult {

	convenience init(data: JSON) {
		self.init()

		type = data[API.type.rawValue].stringValue
		id = data[API.id.rawValue].stringValue
		size = data[API.size.rawValue].intValue
		price = data[API.price.rawValue].intValue
		face = data[API.face.rawValue].stringValue
		stock = data[API.stock.rawValue].intValue

		data[API.tags.rawValue].arrayValue.forEach({ tags.append(StringObject(stringValue: $0.stringValue)) })
	}
}