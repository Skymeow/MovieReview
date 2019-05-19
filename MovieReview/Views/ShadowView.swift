//
//  ShadowView.swift
//  MovieReview
//
//  Created by Sky Xu on 5/19/19.
//  Copyright © 2019 Mingze Xu. All rights reserved.
//

import Foundation
import UIKit

// fix the problem of UIBezierPath depends on shadowLayer's bounds, but it's not gonna properly set by the time cellForRowAtIndexPath is called.
class ShadowView: UIView {
    struct Constants {
        static let radius: CGFloat = 20
    }
    
    override var bounds: CGRect {
        didSet {
            setupShadow()
        }
    }
    
    private func setupShadow() {
        self.layer.cornerRadius = Constants.radius
        self.layer.shadowOffset = CGSize(width: 1, height: 2)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.35
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: Constants.radius, height: Constants.radius)).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}
