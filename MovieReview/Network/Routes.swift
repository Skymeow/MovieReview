//
//  Routes.swift
//  MovieReview
//
//  Created by Mingze Xu on 5/14/19.
//  Copyright © 2019 Mingze Xu. All rights reserved.
//

import Foundation
import Alamofire

// - MARK: Routes

enum Routes {
    case allMovies
    case userProfile
    
    var baseURLString: String {
        switch self {
        case .allMovies:
            return "http://private-anon-f4370bd4a8-iosinterview1.apiary-mock.com/movies/genres"
        case .userProfile:
            return "http://private-anon-f4370bd4a8-iosinterview1.apiary-mock.com/users/me"
        }
    }
    
    var parameters: [String: String] {
        switch self {
        default:
            return [:]
        }
    }
}
