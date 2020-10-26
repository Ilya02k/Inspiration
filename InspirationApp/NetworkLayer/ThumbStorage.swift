//
//  ThumbStorage.swift
//  InspirationApp
//
//  Created by Илья Козлов on 10/4/20.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit
import Foundation


typealias ImageHandler = (NSString ) -> ()
class ThumbStorage {

    let cashe: NSCache<NSURL , UIImage >
    
    //MARK: singlton
    private static var sharedInstance: ThumbStorage?
    private init() {
        self.cashe = NSCache()
        
    }
    
    static func shared () -> ThumbStorage {
        if sharedInstance == nil{
            sharedInstance = shared()
        }
        return sharedInstance!
    }
    
    //
    
    
    
    
}
