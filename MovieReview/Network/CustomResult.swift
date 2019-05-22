//
//  CustomResult.swift
//  MovieReview
//
//  Created by Mingze Xu on 5/14/19.
//  Copyright © 2019 Mingze Xu. All rights reserved.
//

import Foundation

//enum CustomResult<Success, Error> {
//    case success(Success)
//    case fail(CustomError)
//}
//better implementation:
typealias CustomResult<Success> = Result<Success, CustomError>
