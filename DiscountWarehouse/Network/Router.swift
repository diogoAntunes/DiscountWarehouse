//
//  Router.swift
//  DiscountWarehouse
//
//  Created by Diogo Antunes on 8/1/16.
//  Copyright © 2016 Diogo. All rights reserved.
//

import Alamofire

enum Router: URLRequestConvertible {

	static let baseURL = "http://74.50.59.155:5000/api/search"

	case GetSearch(inStock: Bool, limit: Int, skip: Int)

	var URLRequest: NSMutableURLRequest {
		let result: (path: String, method: Alamofire.Method, parameters: [String: AnyObject]?) = {
			switch self {
			case .GetSearch(let inStock, let limit, let skip):
				return ("", .GET, [
					"onlyInStock": inStock,
					"limit": limit,
					"skip": skip
				])
			}
		}()

		let URL = NSURL(string: Router.baseURL)!
		let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(result.path),
			cachePolicy: .ReturnCacheDataElseLoad, timeoutInterval: 20)
		mutableURLRequest.HTTPMethod = result.method.rawValue

		switch self {
		case .GetSearch:
			let encoding = Alamofire.ParameterEncoding.URL
			mutableURLRequest.setValue(Headers.AcceptValue, forHTTPHeaderField: Headers.Accept)
			mutableURLRequest.setValue(Headers.ContentTypeValueJson, forHTTPHeaderField: Headers.ContentType)
            mutableURLRequest.addValue("private", forHTTPHeaderField: "Cache-Control")
            
			return encoding.encode(mutableURLRequest, parameters: result.parameters).0
		}

	}
}