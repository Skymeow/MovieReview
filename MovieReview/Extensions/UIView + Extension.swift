//
//  UIView + Extension.swift
//  MovieReview
//
//  Created by Mingze Xu on 5/15/19.
//  Copyright © 2019 Mingze Xu. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func constrainToParent(insets: UIEdgeInsets = .zero) {
        guard let parent = superview else { return }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        let metrics = ["left": insets.left, "right": insets.right, "top": insets.top, "bottom": insets.bottom]
        
        parent.addConstraints(["H:|-(left)-[view]-(right)-|", "V:|-(top)-[view]-(bottom)-|"].flatMap {
            NSLayoutConstraint.constraints(withVisualFormat: $0, metrics: metrics, views: ["view": self])
        })
    }
}
