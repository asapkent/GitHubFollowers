//
//  GFUserInfoHeaderVC.swift
//  GitHubFollowers
//
//  Created by Robert Jeffers on 8/18/20.
//  Copyright © 2020 AsapInc. All rights reserved.
//

import UIKit

class GFUserInfoHeaderVC: UIViewController {
    
    let avitarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .left, fontSize: 34)
    let nameLabel = GFSecondaryTitleLabel(fontSize: 18)
    let locationImageView = UIImageView()
    let locationLabel = GFSecondaryTitleLabel(fontSize: 18)
    let bioLabel = GFBodyLabel(textAlignment: .left)
    
    var user: User!
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        layoutUI()
        configureUIElements()
    }
    
    func addSubViews() {
        view.addSubview(avitarImageView)
        view.addSubview(usernameLabel)
        view.addSubview(nameLabel)
        view.addSubview(locationImageView)
        view.addSubview(locationLabel)
        view.addSubview(bioLabel)
    }
    
    func configureUIElements() {
        avitarImageView.downloadImage(for: user.avatarUrl)
        usernameLabel.text = user.login
        nameLabel.text = user.name ?? "N/A"
        locationLabel.text = user.location ?? "N/A"
        bioLabel.text = user.bio ?? "N/A"
        bioLabel.numberOfLines = 3
        
        locationImageView.image = UIImage(systemName: SFSymbols.location)
        locationImageView.tintColor = .secondaryLabel
    }
    
    func layoutUI() {
        let padding: CGFloat = 20
        let textImagePadding: CGFloat = 12
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            avitarImageView.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: padding),
            avitarImageView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: padding),
            avitarImageView.widthAnchor.constraint(equalToConstant: 90),
            avitarImageView.heightAnchor.constraint(equalToConstant: 90),
            
            usernameLabel.topAnchor.constraint(equalTo: avitarImageView.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: avitarImageView.trailingAnchor, multiplier: textImagePadding),
            usernameLabel.trailingAnchor.constraint(equalToSystemSpacingAfter: view.trailingAnchor, multiplier: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 38),
           
            nameLabel.centerYAnchor.constraint(equalToSystemSpacingBelow: avitarImageView.centerYAnchor, multiplier: 8),
            nameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: avitarImageView.trailingAnchor, multiplier: textImagePadding),
            nameLabel.trailingAnchor.constraint(equalToSystemSpacingAfter: view.trailingAnchor, multiplier: -padding),
            nameLabel.heightAnchor.constraint(equalToConstant: 38),
            
            locationImageView.bottomAnchor.constraint(equalTo: avitarImageView.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalToSystemSpacingAfter: avitarImageView.trailingAnchor, multiplier: textImagePadding),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),
            
            locationLabel.centerYAnchor.constraint(equalToSystemSpacingBelow: locationImageView.centerYAnchor, multiplier: 0),
            locationLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: locationImageView.trailingAnchor, multiplier: 5),
            locationLabel.trailingAnchor.constraint(equalToSystemSpacingAfter: view.trailingAnchor, multiplier: -padding),
            locationLabel.heightAnchor.constraint(equalToConstant: 20),
            
            bioLabel.topAnchor.constraint(equalToSystemSpacingBelow: avitarImageView.bottomAnchor, multiplier: padding),
            bioLabel.leadingAnchor.constraint(equalTo: avitarImageView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalToSystemSpacingAfter: view.trailingAnchor, multiplier: -padding),
            bioLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
   }
}
