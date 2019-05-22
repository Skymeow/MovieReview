//
//  MovieListTableViewCell.swift
//  MovieReview
//
//  Created by Mingze Xu on 5/14/19.
//  Copyright © 2019 Mingze Xu. All rights reserved.
//

import UIKit

// - MARK: tabelview cell delegate
protocol MovieListTableViewCellDelegate {
    func passPreviewCell(for cell: MovieCollectionViewCell)
}

class MovieListTableViewCell: UITableViewCell, IdentifiableNibBasedCell {
    struct Constants {
        static let standardSpacing: CGFloat = 15.0
        static let standardMargin: CGFloat = 20.0
        /// Margin from right anchor of safe area to right anchor of Image
        static let collectionViewVerticalInset: CGFloat = 2.0
        static let collectionViewHeight: CGFloat = 210
        static let collectionViewWidth: CGFloat = 140
    }
    
    private var collectionViewLayout = UICollectionViewFlowLayout()
    @IBOutlet weak var collectionView: UICollectionView!
    private var moviesPerGenre = [Movie]()
    weak var parentViewController: TrailersViewController?
    var delegate: MovieListTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.collectionViewLayout.invalidateLayout()
        self.configureCollectionView()
    }
    
    func configureCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.registerCell(MovieCollectionViewCell.self)
        self.contentView.backgroundColor = .white
        self.collectionView.backgroundColor = .white
        
        self.collectionViewLayout.minimumInteritemSpacing = Constants.standardMargin
        self.collectionViewLayout.minimumLineSpacing = Constants.standardSpacing
        self.collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: Constants.standardSpacing, bottom: 0, right: Constants.standardSpacing)
        self.collectionViewLayout.scrollDirection = .horizontal
        self.collectionView.collectionViewLayout = self.collectionViewLayout
    }
    
    func reloadCollectionView(movies: [Movie]) {
        self.moviesPerGenre = movies
        self.collectionView.reloadData()
    }
}

// - MARK: Tableview related delegate
extension MovieListTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let itemSpacing = layout.minimumInteritemSpacing
        let insets = layout.sectionInset.left + layout.sectionInset.right

        return CGSize(width: self.collectionView.bounds.width * 0.5 - (insets + itemSpacing), height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.moviesPerGenre.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueCell(MovieCollectionViewCell.self, for: indexPath)
        cell.configureCell(movie: self.moviesPerGenre[indexPath.row])
        self.delegate?.passPreviewCell(for: cell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        defer {
            collectionView.deselectItem(at: indexPath, animated: true)
        }
        guard let detailViewController = UIStoryboard.initialViewController(for: .detail) as? DetailViewController else { return }
        detailViewController.movie = self.moviesPerGenre[indexPath.row]
        self.parentViewController?.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
