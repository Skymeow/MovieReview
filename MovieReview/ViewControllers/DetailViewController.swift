//
//  DetailViewController.swift
//  MovieReview
//
//  Created by Mingze Xu on 5/15/19.
//  Copyright © 2019 Mingze Xu. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class DetailViewController: UIViewController {
    struct Constants {
        static let standardSpacing: CGFloat = 10.0
        static let standardMargin: CGFloat = 10.0
        /// Margin from right anchor of safe area to right anchor of Image
        static let collectionViewVerticalInset: CGFloat = 2.0
    }
    
    // - MARK: property
    var movie: Movie!
    @IBOutlet weak var synopsisTextView: UITextView!
    @IBOutlet weak var synopsisContentView: UIView!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var imdbScoreLabel: UILabel!
    @IBOutlet weak var rtScoreLabel: UILabel!
    @IBOutlet weak var moveiDetailContainerView: UIView!
    @IBOutlet weak var scrollContentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var collectionView: UICollectionView!
    private var collectionViewLayout = UICollectionViewFlowLayout()
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var openWebViewButton: UIButton!
    
    // - MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.configureUI()
        self.setupScrollView()
        self.configureCollectionView()
        self.configureButton()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    // - MARK: UI
    
    private func configureButton() {
        self.likeButton.clipsToBounds = true
        self.likeButton.layer.cornerRadius = self.likeButton.bounds.width / 2
        
        self.likeButton.setImage(UIImage(named : "button_heart"), for: .normal)
        self.likeButton.setImage(UIImage(named : "button_heart_selected"), for: .selected)
        self.likeButton.setBackgroundColor(color: .white, forState: .normal)
        self.likeButton.setBackgroundColor(color: UIColor.darkPinkColor, forState: .selected)
        self.likeButton.backgroundColor = .white
        self.likeButton.layer.borderColor = UIColor.black.cgColor
        self.likeButton.layer.borderWidth = 1
        self.likeButton.tintColor = .white
        
        self.openWebViewButton.clipsToBounds = true
        self.openWebViewButton.layer.cornerRadius = self.openWebViewButton.bounds.width / 2
        self.openWebViewButton.backgroundColor = UIColor.black
        self.openWebViewButton.tintColor = .white
        self.openWebViewButton.setImage(UIImage(named : "button_Webview"), for: .normal)
    }
    
    private func setupNavigationBar() {
        self.tabBarController?.tabBar.isHidden = true
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.title = self.movie.title
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "share_button")
        let shareButton = UIBarButtonItem(customView: imageView)
        shareButton.width = 15
        imageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(shareTapped))
        imageView.addGestureRecognizer(tapGesture)
        self.navigationItem.rightBarButtonItems = [shareButton]
        
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
    }
    
    private func setupScrollView() {
        self.scrollView.contentSize = self.scrollContentView.bounds.size
        let scrollViewBounds = self.scrollContentView.bounds
        let contentViewBounds = self.scrollContentView.bounds
        
        var scrollViewInsets = UIEdgeInsets.zero
        scrollViewInsets.top = scrollViewBounds.size.height
        scrollViewInsets.top -= contentViewBounds.size.height
        
        scrollViewInsets.bottom = scrollViewBounds.size.height
        scrollViewInsets.bottom -= contentViewBounds.size.height
        scrollViewInsets.bottom += 1
        self.scrollView.contentInset = scrollViewInsets
    }
    
    private func configureCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
         self.collectionView.registerCell(MovieCastCollectionViewCell.self)
        self.collectionView.backgroundColor = .white
        self.collectionViewLayout.minimumInteritemSpacing = Constants.standardMargin
        self.collectionViewLayout.minimumLineSpacing = Constants.standardSpacing
        self.collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: Constants.standardSpacing)
        self.collectionViewLayout.scrollDirection = .horizontal
        self.collectionView.collectionViewLayout = self.collectionViewLayout
        self.collectionView.reloadData()
    }
    
    private func configureUI() {
        if let imageUrl = URL(string: movie.imageUrl) {
            self.movieImageView.kf.setImage(with: imageUrl)
        } else {
            self.movieImageView.image = UIImage(named: "placeHolder")
        }
        self.imdbScoreLabel.text = "\(self.movie.imdbScore)"
        self.rtScoreLabel.text = "\(self.movie.rtScore)"
        self.synopsisTextView.text = self.movie.synopsis
    }
    
    // - MARK: Actions
    
    @objc private func shareTapped() {
        let textToShare = "Hey check out \(self.movie.title)! It has a \(self.movie.imdbScore) on IMDB and stars \(self.movie.casts[0])"
        var imageToshare = UIImage()
        guard let imageURL = URL(string: self.movie.imageUrl) else { return }
        KingfisherManager.shared.retrieveImage(with: imageURL, options: nil, progressBlock: nil, completionHandler: { image, err, cacheType, imageURL in
            guard let image = image else { return }
            imageToshare = image
        })
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [textToShare, imageToshare], applicationActivities: nil)
        activityViewController.excludedActivityTypes = [
            UIActivity.ActivityType.message,
            UIActivity.ActivityType.mail,
            UIActivity.ActivityType.postToFacebook,
            UIActivity.ActivityType.print,
            UIActivity.ActivityType.addToReadingList,
            UIActivity.ActivityType.copyToPasteboard,
        ]
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        self.likeButton.isSelected = !self.likeButton.isSelected
    }
    
    @IBAction func openWebTapped(_ sender: UIButton) {
        guard let url = URL(string: self.movie.sourceUrl) else { return }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
   
}

// - MARK: CollectionView related delegate

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movie.casts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueCell(MovieCastCollectionViewCell.self, for: indexPath)
        cell.configureCell(cast: self.movie.casts[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        defer {
            collectionView.deselectItem(at: indexPath, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let itemSpacing = layout.minimumInteritemSpacing
        let insets = layout.sectionInset.left + layout.sectionInset.right
        return CGSize(width: self.collectionView.bounds.width * 0.3 - (insets + itemSpacing), height: collectionView.bounds.height)
    }
}
