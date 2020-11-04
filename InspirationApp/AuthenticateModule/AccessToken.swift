//
//  AccessToken.swift
//  InspirationApp
//
//  Created by Илья Козлов on 10/29/20.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

protocol AccessTokenModelType {
    var accessToken: String { get }
}

struct AccessToken: Codable, AccessTokenModelType {
    var accessToken: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        accessToken = try container.decode(String.self, forKey: .accessToken)
    }
    
}



