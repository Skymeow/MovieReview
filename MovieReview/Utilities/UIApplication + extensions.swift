//
//  UIApplication + extensions.swift
//  MovieReview
//
//  Created by Sky Xu on 5/19/19.
//  Copyright © 2019 Mingze Xu. All rights reserved.
//

import Foundation
import UIKit

// MARK: find Top most viewController
extension UIApplication {
    class func topMostViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let navigation = base as? UINavigationController {
            guard let visibleViewController = navigation.visibleViewController else { return navigation }
            return topMostViewController(base: visibleViewController)
        }
        
        if let tab = base as? UITabBarController {
            if let selectedTab = tab.selectedViewController {
                return topMostViewController(base: selectedTab)
            } else {
                return topMostViewController(base: tab)
            }
        }
        
        if let presented = base?.presentedViewController {
            return topMostViewController(base: presented)
        }
        return base
    }
}
