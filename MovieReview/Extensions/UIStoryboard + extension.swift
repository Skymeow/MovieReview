//
//  UIStoryboard + extension.swift
//  MovieReview
//
//  Created by Mingze Xu on 5/15/19.
//  Copyright © 2019 Mingze Xu. All rights reserved.
//

import Foundation
import UIKit

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension UIViewController: StoryboardIdentifiable { }

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}

extension UIStoryboard {
    enum StorybooardType: String {
        case main = "Main"
        case detail = "Detail"
        
        var filename: String {
            return self.rawValue
        }
    }
    
    convenience init(type: StorybooardType, bundle: Bundle? = nil) {
        self.init(name: type.filename, bundle: bundle)
    }
    
    static func initialViewController(for type: StorybooardType) -> UIViewController {
        let storyboard = UIStoryboard(type: type)
        guard let initialViewController = storyboard.instantiateInitialViewController() else {
            fatalError("Couldn't instantiate initial view controller for \(type.filename) storyboard.")
        }
        
        return initialViewController
    }
    
    func instantiateViewController<T: UIViewController>() -> T {
        guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("Failed to find \(T.storyboardIdentifier)")
        }
        return viewController
    }
}
