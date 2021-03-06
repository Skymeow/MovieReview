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
    
    @IBOutlet weak var shadowView: ShadowView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var backgroundMaskView: UIView!
    private var movie: Movie?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // add mask
        self.imageView.clipsToBounds = true
        self.backgroundMaskView.clipsToBounds = true
        self.imageView.layer.cornerRadius = Constants.cellCornerRadius
        self.backgroundMaskView.layer.cornerRadius = Constants.cellCornerRadius
    }
    
    func configureCell(movie: Movie) {
        self.movie = movie
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


extension MovieCollectionViewCell: UIViewControllerPreviewingDelegate {
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let detailVC = UIStoryboard.initialViewController(for: .detail) as? DetailViewController, let superview = self.superview, let movie = self.movie else {
            guard let topMostViewController = UIApplication.topMostViewController() else { print("can't find top most view controller"); return nil }
            topMostViewController.presentAlert(title: "Not able to generate content for movie detail")
            return nil
        }
        let rect = self.convert(self.frame, from: superview)
        detailVC.movie = movie
        previewingContext.sourceRect = rect
        return detailVC
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        guard let topMostViewController = UIApplication.topMostViewController() else { print("can't find top most view controller"); return }
        topMostViewController.navigationController?.show(viewControllerToCommit, sender: self)
    }
}


