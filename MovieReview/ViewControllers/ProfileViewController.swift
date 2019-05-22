//
//  ViewController.swift
//  MovieReview
//
//  Created by Mingze Xu on 5/13/19.
//  Copyright © 2019 Mingze Xu. All rights reserved.
//

import UIKit
import Alamofire

class ProfileViewController: UIViewController {

    @IBOutlet weak var switchView: UISwitch!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.switchView.onTintColor = UIColor.darkPinkColor
        self.profileImageView.clipsToBounds = true
        self.profileImageView.layer.cornerRadius = self.profileImageView.bounds.width / 2
        self.fetchUser()
    }

    private func setupUI(for user: UserProfile) {
        self.profileImageView.kf.indicatorType = .activity
        self.profileImageView.contentMode = .scaleAspectFill
        if let imageUrl = URL(string: user.pictureUrl) {
            self.profileImageView.kf.setImage(with: imageUrl)
        } else {
            self.profileImageView.image = UIImage(named: "placeHolder")
        }
        self.switchView.isOn = user.locationEnabled
        self.userNameLabel.text = user.firstName + " " + user.lastName
        self.slider.value = Float(user.suggestionRadius)
    }
    
    private func fetchUser() {
        RequestManager.shared.fetchRequest(route: .userProfile, modelType: UserProfile.self) { [weak self] (result) in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    strongSelf.setupUI(for: data)
                }
            case .failure(let error):
                print(error)
                strongSelf.presentRetryOrDismissAlert(title: "Network Error", message: "Failed to load user", retry: { [unowned strongSelf] (action) in
                    strongSelf.fetchUser()
                })
            }
        }
    }

}

