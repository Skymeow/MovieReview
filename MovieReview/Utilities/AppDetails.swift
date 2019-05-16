//
//  AppDetails.swift
//  MovieReview
//
//  Created by Mingze Xu on 5/14/19.
//  Copyright © 2019 Mingze Xu. All rights reserved.
//

import Foundation
import UIKit

class AppDetails {
    static var appName: String {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleNameKey as String) as! String
    }
    
    static var version: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    }
    
    static var buildNumber: String {
        if let buildVersion = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String {
            return buildVersion
        } else {
            return "UnknownBuild"
        }
    }
    
    static var bundleIdentifier: String {
        return Bundle.main.bundleIdentifier!
    }
}
