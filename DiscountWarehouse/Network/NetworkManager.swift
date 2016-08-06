//
//  NetworkManager.swift
//  DiscountWarehouse
//
//  Created by Diogo Antunes on 8/1/16.
//  Copyright © 2016 Diogo. All rights reserved.
//

import Alamofire
import SwiftyJSON
import RealmSwift

final class NetworkManager {

	// Network Singleton
	static let sharedInstance = NetworkManager()
	private init() { }

	// Realm
	let realm = try! Realm()

	lazy var searchResults: Results<SearchResult> = { self.realm.objects(SearchResult) }()

}

extension NetworkManager: NetworkProtocol {

	/*** All the search results  ***/
	func getSearchResults(onlyInStock: Bool, limit: Int, skip: Int, completion: Result<[SearchResult]> -> Void) {
		alamofireCall(.GetSearch(inStock: onlyInStock, limit: limit, skip: skip),
			success: { result in

				let searchResults = result.arrayValue.map({ SearchResult(data: $0) })
				self.cacheTheResults(searchResults)
				completion(.Success(searchResults))

			}, failure: { error in
				completion(.Failure(error))
		})
	}

	private func cacheTheResults(results: [SearchResult]) {
		try! realm.write() {
			realm.add(searchResults)
			searchResults = self.realm.objects(SearchResult)
		}
	}

}

extension NetworkManager {

	typealias successResponse = (result: JSON) -> Void
	typealias failureResponse = (error: BackendError) -> Void

	private func alamofireCall(requestURL: Router, success: successResponse, failure: failureResponse) {
		Alamofire.request(requestURL)
			.debugLog()
			.validate()
			.responseData() { response in
				switch response.result {
				case .Success(let nsdata):
					do {
						let json = try NDJSON.parse(nsdata)
						success(result: JSON(json))
					} catch {
						failure(error: .Fail)
					}
				case .Failure(let error):
					print(error)
					failure(error: .Fail)
				}
		}
	}
}