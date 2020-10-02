//
//  ServiceLayer.swift
//  InspirationApp
//
//  Created by Илья Козлов on 9/30/20.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

//class ServiceLayer {
    // 1.
//    class func request<T: Codable>(router: Router2, completion: @escaping (Result<[String: [T]], Error>) -> ()) {
//        // 2.
//        var components = URLComponents()
//        components.scheme = router.scheme
//        components.host = router.host
//        components.path = router.path
//        components.queryItems = router.parameters
//        // 3.
//        guard let url = components.url else { return }
//        var urlRequest = URLRequest(url: url)
//        urlRequest.httpMethod = router.method
//        // 4.
//        let session = URLSession(configuration: .default)
//        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
//            // 5.
//            if let err = error {
//                completion(.failure(err))
//                print(err.localizedDescription)
//                return
//            }
//            guard response != nil, let data = data else {
//                return
//            }
//            // 6.
//            let responseObject = try! JSONDecoder().decode([String: [T]].self, from: data)
//            // 7.
//            DispatchQueue.main.async {
//                // 8.
//                completion(.success(responseObject))
//            }
//        }
//        dataTask.resume()
//    }
//}

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
            // 6.
            if let responseObject = try? JSONDecoder().decode(T.self, from: data) {
                completion(.success(responseObject))
                return
            }
            completion(.failure(NSError.init(domain: "", code: NSURLErrorCannotDecodeContentData, userInfo: nil)))
            
        }.resume()
        
    }
    
    
}
