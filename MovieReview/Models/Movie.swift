//
//  Movie.swift
//  MovieReview
//
//  Created by Mingze Xu on 5/13/19.
//  Copyright © 2019 Mingze Xu. All rights reserved.
//

import Foundation

class Movie: Decodable {
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
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.imageUrl = try container.decode(String.self, forKey: .imageUrl)
        self.imdbScore = try container.decode(Float.self, forKey: .imdbScore)
        self.liked = try container.decode(Bool.self, forKey: .liked)
        self.synopsis = try container.decode(String.self, forKey: .synopsis)
        self.rtScore = try container.decode(Int.self, forKey: .rtScore)
        self.sourceUrl = try container.decode(String.self, forKey: .sourceUrl)
        self.casts = try container.decode([Cast].self, forKey: .casts)
        self.id = try container.decode(String.self, forKey: .id)
    }
    
}
