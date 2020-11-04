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
    
    case getToken(code: String)
    
    
    var scheme: String {
        switch self {
        case .getPhotos, .getSearchResults, .getToken :
            return "https"
        }
    }
    var host: String {
        switch self {
        case .getPhotos, .getSearchResults:
            return "api.unsplash.com"
        case .getToken:
            return "unsplash.com"
        }
    }
    
    var path: String {
        switch self {
        case .getPhotos:
            return "/photos/random"
        case .getSearchResults:
            return "/search/photos"
        case .getToken:
           return "/oauth/token"
        }
    }
    
    var parameters: [URLQueryItem] {
        let cliendIdConst = "NqjzpaBLzRLHwexqIhm4vvXvb4rGo5M2nPQj4vWJKYY"
        let clientSecretKey = "geS_47ls8YfiDUeZn_ElLEGxGwYOWzY4XrkG1D4D1xw"
        let redirectUri = "urn:ietf:wg:oauth:2.0:oob"
        switch self {
        case .getPhotos:
            return [URLQueryItem(name: "count", value: "30"),
                    URLQueryItem(name: "client_id", value: cliendIdConst)]
        case let .getSearchResults(searchText):
            return [URLQueryItem(name: "query", value: searchText),
                    URLQueryItem(name: "client_id", value: cliendIdConst)]
        case let .getToken(code):
            return [URLQueryItem(name: "client_id", value: cliendIdConst)
                ,URLQueryItem(name: "client_secret", value: clientSecretKey),
            URLQueryItem(name: "redirect_uri", value: redirectUri),
           // URLQueryItem(name: "scope*", value: "public+write_likes"),
           // URLQueryItem(name: "response_type", value: "code"),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            //URLQueryItem(name: "Accept-Version", value: "v1")
            ]
        }
    }
    
    var method: String {
        switch self {
        case .getPhotos, .getSearchResults, .getToken:
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
