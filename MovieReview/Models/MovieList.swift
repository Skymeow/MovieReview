//
//  MovieList.swift
//  MovieReview
//
//  Created by Mingze Xu on 5/13/19.
//  Copyright © 2019 Mingze Xu. All rights reserved.
//

import Foundation

struct MovieList: Decodable {
    let category: String
    let id: String
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case category = "name"
        case id
        case movies
    }
}
