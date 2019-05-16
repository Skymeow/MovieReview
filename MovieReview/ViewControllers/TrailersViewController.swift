//
//  TrailersViewController.swift
//  MovieReview
//
//  Created by Mingze Xu on 5/13/19.
//  Copyright © 2019 Mingze Xu. All rights reserved.
//

import UIKit

class TrailersViewController: UIViewController {
    struct Constants {
        static let tableViewSectionHeaderHeight: CGFloat = 65
        static let collectionViewHeight: CGFloat = 230
    }
    
    @IBOutlet weak var tableView: UITableView!
    private let refreshControl = UIRefreshControl(frame: .zero)
    private var movieLists: [MovieList]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchMovieLists()
        self.configureTableView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    @objc func refreshControlChangedStatus(_ refreshControl: UIRefreshControl) {
        if refreshControl.isRefreshing {
            self.fetchMovieLists()
        }
    }
    
    private func configureTableView() {
        self.refreshControl.addTarget(self, action: #selector(self.refreshControlChangedStatus(_:)), for: .valueChanged)
        self.tableView.refreshControl = self.refreshControl
        
        self.tableView.bounces = true
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerIdentifiableCell(MovieListTableViewCell.self)
        
        self.tableView.estimatedRowHeight = Constants.collectionViewHeight
        self.tableView.rowHeight = Constants.collectionViewHeight
        self.tableView.estimatedSectionHeaderHeight = Constants.tableViewSectionHeaderHeight
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorStyle = .none
    }
    
    private func fetchMovieLists() {
        RequestManager.shared.fetchRequest(route: .allMovies, modelType: [MovieList].self) { [weak self] (result) in
            guard let strongSelf = self else { return }
            strongSelf.refreshControl.endRefreshing()
            switch result {
            case .success(let data):
                strongSelf.movieLists = data
            case .fail(let error):
                print(error)
                strongSelf.presentRetryOrDismissAlert(title: "Network Error", message: "Failed to load movies", retry: { [unowned strongSelf] (action) in
                    strongSelf.fetchMovieLists()
                })
            }
        }
        
    }
}

extension TrailersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.movieLists?.count ?? 0
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeuIdentifiableCell(MovieListTableViewCell.self, indexPath: indexPath)
        guard let movies = self.movieLists?[indexPath.section].movies else { print("empty movies data"); return UITableViewCell() }
        cell.configureCollectionView(movies: movies)
        cell.parentViewController = self
        return cell
    }
  
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .white
        let titleLable = UILabel()
        titleLable.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(titleLable)
        NSLayoutConstraint.activate([
            titleLable.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            titleLable.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -25),
            titleLable.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 5),
            titleLable.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -10),
            ])
        titleLable.text = self.movieLists?[section].category
        titleLable.textColor = UIColor.darkPinkColor
        titleLable.font = UIFont.systemFont(ofSize: 24.0, weight: .bold)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.tableViewSectionHeaderHeight
    }
}
