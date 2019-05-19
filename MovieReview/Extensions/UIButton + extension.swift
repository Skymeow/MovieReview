//
//  UIButton + extension.swift
//  MovieReview
//
//  Created by Mingze Xu on 5/15/19.
//  Copyright © 2019 Mingze Xu. All rights reserved.
//

import Foundation
import UIKit

// UIColor -> set BackgroundImage
extension UIButton {
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        guard let currentContext = UIGraphicsGetCurrentContext() else { return }
        currentContext.setFillColor(color.cgColor)
        currentContext.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.setBackgroundImage(colorImage, for: forState)
    }
}

