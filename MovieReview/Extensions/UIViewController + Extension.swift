//
//  UIViewController + Extension.swift
//  MovieReview
//
//  Created by Mingze Xu on 5/15/19.
//  Copyright © 2019 Mingze Xu. All rights reserved.
//

import Foundation
import UIKit

// Alert view
extension UIViewController {
    
    public enum AlertDismissStyle {
        case dismiss
        case cancel
    }
    
    public func presentRetryOrDismissAlert(title: String, message: String? = nil, dismissStyle: AlertDismissStyle? = .dismiss, retry: ((UIAlertAction) -> Void)? = nil, dismiss: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let retryAction = UIAlertAction(title: "Retry", style: .default, handler: retry)
        alertController.addAction(retryAction)
        
        let dismissAction = UIAlertAction(title: "dismiss", style: .cancel, handler: dismiss)
        alertController.addAction(dismissAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
        UINotificationFeedbackGenerator().notificationOccurred(.error)
    }
    
    public func presentAlert(title: String, message: String? = nil, dismissClosure: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Ok", style: .default, handler: dismissClosure)
        alertController.addAction(dismissAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
            UIAccessibility.post(notification: .layoutChanged, argument: alertController)
        }
        UINotificationFeedbackGenerator().notificationOccurred(.error)
    }
}
