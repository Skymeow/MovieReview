//
//  RequestManager.swift
//  MovieReview
//
//  Created by Mingze Xu on 5/14/19.
//  Copyright © 2019 Mingze Xu. All rights reserved.
//

import Foundation
import Alamofire

class RequestManager {
    
    static let shared = RequestManager()
    
    func fetchRequest<T: Decodable>(route: Routes, modelType: T.Type, _ completion: @escaping(CustomResult<T, CustomError?>) -> Void) {
        Alamofire.request(route.baseURLString, method: .get, parameters: route.parameters).responseData { (response) in
            switch response.result {
            case .success:
                guard let data = response.data else { print("response data invalid"); return }
                do {
                    let decodedModel = try JSONDecoder().decode(modelType.self, from: data)
                    completion(.success(decodedModel))
                } catch let err {
                    print(err)
                    completion(.fail(CustomError.parsingError))
                }
            case .failure(let error):
                completion(.fail(CustomError.serverError(ServerError.genericError(code: error.localizedDescription, message: "server error in fetch movie list"))))
            }
        }
    }
}
