//
//  SearchResultsViewModel.swift
//  DiscountWarehouse
//
//  Created by Diogo Antunes on 8/9/16.
//  Copyright © 2016 Diogo. All rights reserved.
//

struct SearchResultsViewModel: Network {

	func getSearchResults(limit: Int, skip: Int, callback: (results: [SearchResult]?) -> Void) {
		Network.getSearchResults(false, limit: limit, skip: skip) { result in
			switch result {
			case .Success(let search): callback(results: search)
			case .Failure: callback(results: nil)
			}
		}
	}

}
