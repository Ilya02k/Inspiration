//
//  PostModel.swift
//  InspirationApp
//
//  Created by Илья Козлов on 9/25/20.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation
import UIKit

struct PhotoModel: Codable {
    
    
    var user: User
    var urls: PhotoUrls
    
//    var isFavorite: Bool
    
    var width: Int
    var height: Int
}
struct User: Codable {
    var name: String
}
struct PhotoUrls: Codable {
    var full: String
}

