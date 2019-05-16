//
//  MovieCastCollectionViewCell.swift
//  MovieReview
//
//  Created by Mingze Xu on 5/15/19.
//  Copyright © 2019 Mingze Xu. All rights reserved.
//

import UIKit
import Kingfisher

class MovieCastCollectionViewCell: UICollectionViewCell, IdentifiableNibBasedCell {

    struct Constants {
        static let cellCornerRadius: CGFloat = 10
    }
    
    @IBOutlet weak var castImageView: UIImageView!
    
    @IBOutlet weak var maskBackgroundView: UIView!
    @IBOutlet weak var castLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.castImageView.clipsToBounds = true
        self.maskBackgroundView.clipsToBounds = true
        self.castImageView.layer.cornerRadius = Constants.cellCornerRadius
        self.maskBackgroundView.layer.cornerRadius = Constants.cellCornerRadius
    }
    
    func configureCell(cast: Cast) {
        self.castLabel.font = UIFont.boldSystemFont(ofSize: 10)
        self.castLabel.text = cast.firstName + " " + cast.lastName
        self.castImageView.kf.indicatorType = .activity
        self.castImageView.contentMode = .scaleAspectFill
        if let imageUrl = URL(string: cast.imageUrl) {
            self.castImageView.kf.setImage(with: imageUrl)
        } else {
            self.castImageView.image = UIImage(named: "placeHolder")
        }
    }

}
