//
//  Router.swift
//  InspirationApp
//
//  Created by Илья Козлов on 9/29/20.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

enum Router2 {

    
    case getPhotos
 
    case getSearchResults(searchText: String)
    
    
    var scheme: String {
        switch self {
        case .getPhotos, .getSearchResults :
            return "https"
        }
    }
    var host: String {
        switch self {
        case .getPhotos, .getSearchResults:
            return "api.unsplash.com"
        }
    }
    
    var path: String {
        switch self {
        case .getPhotos:
            return "/photos/random"
        case .getSearchResults:
            return "/search/photos"
        }
    }
    
    var parameters: [URLQueryItem] {
        let cliendIdConst = "NqjzpaBLzRLHwexqIhm4vvXvb4rGo5M2nPQj4vWJKYY"
        switch self {
        case .getPhotos:
            return [URLQueryItem(name: "count", value: "30"),
                    URLQueryItem(name: "client_id", value: cliendIdConst)]
        case let .getSearchResults(searchText):
            return [URLQueryItem(name: "query", value: searchText),
                    URLQueryItem(name: "client_id", value: cliendIdConst)]
        }
    }
    
    var method: String {
        switch self {
        case .getPhotos, .getSearchResults:
            return "GET"
        }
    }
    var urlRequest: URLRequest {
        var components=URLComponents.init()
        components.scheme = self.scheme
        components.host = self.host
        components.path = self.path
        components.queryItems = self.parameters
        var request = URLRequest.init(url: components.url!)
        request.httpMethod = self.method
        return request
    }
    
}
