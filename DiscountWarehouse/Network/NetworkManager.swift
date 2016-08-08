//
//  NetworkManager.swift
//  DiscountWarehouse
//
//  Created by Diogo Antunes on 8/1/16.
//  Copyright © 2016 Diogo. All rights reserved.
//

import Alamofire
import SwiftyJSON

final class NetworkManager {
    
    // Alamofire
    var cachePolicy: NSURLRequestCachePolicy = .UseProtocolCachePolicy
    var cacheDuration: NSTimeInterval = 1 * 60 * 60
    var timeOut: NSTimeInterval = 30
    
    let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
    var manager: Manager?
    
    // Network Singleton
    static let sharedInstance = NetworkManager()
    private init() {
        self.manager = Manager(configuration: urlSessionConfiguration())
        self.manager?.delegate.dataTaskWillCacheResponse = {
            (urlSession: NSURLSession, dataTask: NSURLSessionDataTask, cachedResponse: NSCachedURLResponse) -> NSCachedURLResponse in
            
            let response = cachedResponse.response as! NSHTTPURLResponse
            var headers = response.allHeaderFields as! [String: String]
            
            headers.removeValueForKey("Expires")
            headers.removeValueForKey("s-maxage")
            headers["Cache-Control"] = String(format: "max-age=%li", self.cacheDuration)
            
            let modifiedResponse = NSHTTPURLResponse(
                URL: response.URL!,
                statusCode: response.statusCode,
                HTTPVersion: "HTTP/1.1",
                headerFields: headers)
            
            let modifiedCachedResponse = NSCachedURLResponse(
                response: modifiedResponse!,
                data: cachedResponse.data,
                userInfo: cachedResponse.userInfo,
                storagePolicy: cachedResponse.storagePolicy)
            
            return modifiedCachedResponse
        }
    }
    
    private func urlSessionConfiguration() -> NSURLSessionConfiguration {
        let urlSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        urlSessionConfiguration.requestCachePolicy = cachePolicy
        urlSessionConfiguration.timeoutIntervalForResource = timeOut
        urlSessionConfiguration.timeoutIntervalForRequest = timeOut
        return urlSessionConfiguration
    }
    
}

extension NetworkManager: NetworkProtocol {
    
    /*** All the search results  ***/
    func getSearchResults(onlyInStock: Bool, limit: Int, skip: Int, completion: Result<[SearchResult]> -> Void) {
        alamofireCall(.GetSearch(inStock: onlyInStock, limit: limit, skip: skip),
            success: { result in
                completion(.Success(result.arrayValue.map({ SearchResult(data: $0) })))
                
            }, failure: { error in
                completion(.Failure(error))
        })
    }
}

extension NetworkManager {
    
    typealias successResponse = (result: JSON) -> Void
    typealias failureResponse = (error: BackendError) -> Void
    
    private func alamofireCall(requestURL: Router, success: successResponse, failure: failureResponse) {
        manager!.request(requestURL)
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
                case .Failure: failure(error: .Fail)
                }
        }
    }
}