//
//  PostModel.swift
//  InspirationApp
//
//  Created by Илья Козлов on 9/25/20.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation
import UIKit

protocol PhotoModelType {
    var user: User { set get }
    var urls: PhotoUrls { set get }
    var width: Int { set get }
    var height: Int { set get }
}

struct PhotoModel: Codable, PhotoModelType {
    
    
    var user: User
    var urls: PhotoUrls
    
    
    var width: Int
    var height: Int
}
struct User: Codable {
    var name: String
}
struct PhotoUrls: Codable {
    var regular: String
}

protocol AdvancedPhotoModelType: PhotoModelType {
   // var base: PhotoModel { get }
}

struct AdvancedPhotoModel: AdvancedPhotoModelType {
    var user: User
    var urls: PhotoUrls
    var width: Int
    var height: Int
    
    
    enum CodingKeys: String, CodingKey {
      case user
      case urls
      case width
      case height
    }
    
    var isFavorite = false
    var image: UIImage?
}

extension AdvancedPhotoModel: Codable {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        user = try container.decode(User.self, forKey: .user)
        urls = try container.decode(PhotoUrls.self, forKey: .urls)
        width = try container.decode(Int.self, forKey: .width)
        height = try container.decode(Int.self, forKey: .height)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(user, forKey: .user)
        try container.encode(urls, forKey: .urls)
        try container.encode(width, forKey: .width)
        try container.encode(height, forKey: .height)
    }
}

struct SearchResults: Codable {
    var results: [AdvancedPhotoModel]
}
