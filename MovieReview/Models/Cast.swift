//
//  Cast.swift
//  MovieReview
//
//  Created by Mingze Xu on 5/13/19.
//  Copyright © 2019 Mingze Xu. All rights reserved.
//

import Foundation

class Cast: Decodable {
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
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.firstName = try container.decode(String.self, forKey: .firstName)
        self.lastName = try container.decode(String.self, forKey: .lastName)
        self.imageUrl = try container.decode(String.self, forKey: .imageUrl)
        self.id = try container.decode(String.self, forKey: .id)
    }
}
