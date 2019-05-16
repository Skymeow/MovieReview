//
//  UIViewController + Extension.swift
//  MovieReview
//
//  Created by Mingze Xu on 5/15/19.
//  Copyright © 2019 Mingze Xu. All rights reserved.
//

import Foundation
import UIKit

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
}
