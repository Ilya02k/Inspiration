//
//  ServiceLayer.swift
//  InspirationApp
//
//  Created by Илья Козлов on 9/30/20.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

protocol URLConvertable {
    var urlRequest: URLRequest { get }
}

class NetworkService {
    private let session: URLSession
    init(session: URLSession) {
        self.session = session
    }
    
    func fetch<T: Codable>(_ provider: Router2, completion: @escaping (Result<T, Error>) -> () ) {
        
        let request = provider.urlRequest
        session.dataTask(with: request) { (data, response, error) in
            guard error == nil  else {
                completion(.failure(error!))
                return } 
            guard response != nil, let data = data else {
                return
            }
          //  let searchResults = da

            if let responseObject = try? JSONDecoder().decode(T.self, from: data) {
                completion(.success(responseObject))
                return
            }
            completion(.failure(NSError.init(domain: "", code: NSURLErrorCannotDecodeContentData, userInfo: nil)))
            
        }.resume()
        
    }
    
    
    
    
}
