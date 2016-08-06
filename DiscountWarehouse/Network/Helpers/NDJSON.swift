//
//  NDJSON.swift
//  DiscountWarehouse
//
//  Created by Diogo Antunes on 8/1/16.
//  Copyright © 2016 Diogo. All rights reserved.
//

import Foundation

final class NDJSON {

	class func parse(data: NSData, options opt: NSJSONReadingOptions = []) throws -> [AnyObject] {
		let nonEmptyLines = String(data: data, encoding: NSUTF8StringEncoding)!
			.componentsSeparatedByString("\n").filter { !$0.isEmpty }
		let string =
			"[" + nonEmptyLines.joinWithSeparator(",")
			+ "]"
		let data = string.dataUsingEncoding(NSUTF8StringEncoding)!
		return try NSJSONSerialization.JSONObjectWithData(data, options: opt) as! [AnyObject]
	}
}