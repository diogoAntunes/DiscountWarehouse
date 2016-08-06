//
//  NetworkProtocol.swift
//  DiscountWarehouse
//
//  Created by Diogo Antunes on 8/1/16.
//  Copyright © 2016 Diogo. All rights reserved.
//

enum Result<T> {
	case Success(T)
	case Failure(BackendError)
}

enum BackendError {
	case Fail
}

protocol NetworkProtocol {

	/*** All the search results  ***/
    func getSearchResults(onlyInStock: Bool, limit: Int, skip: Int, completion: Result<[SearchResult]> -> Void)
}