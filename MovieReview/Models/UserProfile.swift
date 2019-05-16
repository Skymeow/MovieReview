//
//  UserProfile.swift
//  MovieReview
//
//  Created by Mingze Xu on 5/14/19.
//  Copyright © 2019 Mingze Xu. All rights reserved.
//

import Foundation

struct UserProfile: Decodable {
    let firstName: String
    let lastName: String
    let pictureUrl: String
    let id: String
    let locationEnabled: Bool
    let suggestionRadius: Int
    
    enum CodingKeys: String, CodingKey {
        case firstName = "given_name"
        case lastName = "family_name"
        case pictureUrl = "picture_url"
        case id
        case locationEnabled = "location_enabled"
        case suggestionRadius = "suggestion_radius"
    }
}
