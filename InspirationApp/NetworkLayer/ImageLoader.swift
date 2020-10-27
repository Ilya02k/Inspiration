//
//  ImageLoader.swift
//  InspirationApp
//
//  Created by Илья Козлов on 10/5/20.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit



class ImageLoader: UIImageView {
    
    let imageCache = NSCache<NSURL , UIImage >()
    var imageURL: URL?
    
    func loadWithUrl(url: URL, completion: @escaping (UIImage?) -> () ) {
        imageURL = url
        image = nil
//        let serialQueue = DispatchQueue(label: "cacheHandlers")
//       serialQueue.sync {
            if let imageFromCache = imageCache.object(forKey: url as NSURL) {
               // DispatchQueue.main.async {
                    self.image = imageFromCache
                     completion(self.image)
               // }
              
              return
            }
       // }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
        
            if error != nil {
                print(error as Any)
                return
            }
            
            
            
            if let unwrappedData = data, let imageToCache = UIImage(data: unwrappedData) {
                
                if self.imageURL?.absoluteString == url.absoluteString {
                    DispatchQueue.main.async {
                        self.image = imageToCache
                        completion(self.image)
                    }
                    
                }
                
              //  serialQueue.sync {
                    self.imageCache.setObject(imageToCache, forKey: url as NSURL)
              //  }
                
                
            }
           
        }).resume()
        
        
    }
    
    
    
}
