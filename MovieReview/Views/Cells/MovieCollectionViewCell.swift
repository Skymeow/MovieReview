//
//  MovieCollectionViewCell.swift
//  MovieReview
//
//  Created by Mingze Xu on 5/14/19.
//  Copyright © 2019 Mingze Xu. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell, IdentifiableNibBasedCell {
    struct Constants {
        static let cellCornerRadius: CGFloat = 20
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var backgroundMaskView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageView.clipsToBounds = true
        self.backgroundMaskView.clipsToBounds = true
        self.imageView.layer.cornerRadius = Constants.cellCornerRadius
        self.backgroundMaskView.layer.cornerRadius = Constants.cellCornerRadius
    }
    
    func configureCell(movie: Movie) {
        self.textLabel.text = movie.title
        self.imageView.kf.indicatorType = .activity
        self.imageView.contentMode = .scaleAspectFill
        if let imageUrl = URL(string: movie.imageUrl) {
            self.imageView.kf.setImage(with: imageUrl)
        } else {
            self.imageView.image = UIImage(named: "placeHolder")
        }
    }
}
