//
//  Request.swift
//  DiscountWarehouse
//
//  Created by Diogo Antunes on 8/1/16.
//  Copyright © 2016 Diogo. All rights reserved.
//

import Alamofire

extension Request {
	public func debugLog() -> Self {
		debugPrint(self)
		return self
	}
}
