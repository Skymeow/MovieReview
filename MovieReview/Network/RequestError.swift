//
//  RequestError.swift
//  MovieReview
//
//  Created by Mingze Xu on 5/14/19.
//  Copyright © 2019 Mingze Xu. All rights reserved.
//

import Foundation
import Alamofire


enum CustomError: Error {
    case parsingError
    case noURLForEndpointAvailable
    case invalidResponse(String)
    case invalidRequest(String)
    case serverError(ServerError)
}

/// Errors explicitly given by the server.
public enum ServerError: LocalizedError, Equatable {
    case unauthorized
    case genericError(code: String, message: String?)
    
    private struct ServerErrorCode {
        static let unauthorized = "UNAUTHORIZED_ACCESS"
    }
    
    init(code: String, message: String?) {
        // Check for specific codes and generate more explicit errors here if we want.
        switch code {
        case ServerErrorCode.unauthorized:
            self = .unauthorized
        default:
            self = .genericError(code: code, message: message)
        }
    }
    
    init?(dictionary: [String: Any]) {
        // Require an errorCode. If we don't find one then exit early.
        guard let serverErrorCode = dictionary["errorCode"] as? String else { return nil }
        
        // Optional message param
        let serverErrorMessage = dictionary["message"] as? String
        
        print("\(serverErrorCode) : \(serverErrorMessage ?? "")")
        
        // Return the ServerError object
        self = ServerError(code: serverErrorCode, message: serverErrorMessage)
    }
    
    public var errorDescription: String? {
        switch self {
        case .unauthorized:
            return "Unauthorized User"
        case .genericError(let code, _):
            return code
        }
    }
    
    public var recoverySuggestion: String? {
        switch self {
        case .unauthorized:
            return AppDetails.appName
        case .genericError(let code, let optionalMessage):
            var suggestions: [String] = []
            let localizedRecoverySuggestion = "\(code)Please contact the Helpline."
            suggestions.append(localizedRecoverySuggestion)
            
            // Add message from the server for Debug builds
            #if DEBUG
            if let message = optionalMessage {
                suggestions.append("[DEBUG] \(message)")
            }
            #endif
            
            return suggestions.count == 0 ? nil : suggestions.joined(separator: "\r\r")
        }
    }
    
    public static func ==(lhs: ServerError, rhs: ServerError) -> Bool {
        switch (lhs, rhs) {
        case (.unauthorized, .unauthorized): return true
        case (.genericError(let lhsCode, _), .genericError(let rhsCode, _)): return lhsCode == rhsCode
        default: return false
        }
    }
}

