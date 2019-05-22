//
//  Cast.swift
//  MovieReview
//
//  Created by Mingze Xu on 5/13/19.
//  Copyright © 2019 Mingze Xu. All rights reserved.
//

import Foundation

struct Cast: Decodable {
    let firstName: String
    let lastName: String
    let imageUrl: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case firstName =  "given_name"
        case lastName = "family_name"
        case imageUrl = "picture_url"
        case id
    }
}
