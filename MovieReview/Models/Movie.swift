//
//  Movie.swift
//  MovieReview
//
//  Created by Mingze Xu on 5/13/19.
//  Copyright © 2019 Mingze Xu. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    let id: String
    let title: String
    let imageUrl: String
    let imdbScore: Float
    let liked: Bool
    let synopsis: String
    let rtScore: Int
    let sourceUrl: String
    let casts: [Cast]
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case imageUrl = "thumbnail_url"
        case imdbScore = "imdb_score"
        case liked
        case synopsis
        case rtScore = "rt_score"
        case sourceUrl = "source_url"
        case casts = "cast"
    }
}
