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
            avitarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avitarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avitarImageView.widthAnchor.constraint(equalToConstant: 90),
            avitarImageView.heightAnchor.constraint(equalToConstant: 90),
            
            usernameLabel.topAnchor.constraint(equalTo: avitarImageView.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avitarImageView.trailingAnchor, constant: textImagePadding),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            usernameLabel.heightAnchor.constraint(equalToConstant: 38),
           
            nameLabel.centerYAnchor.constraint(equalTo: avitarImageView.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avitarImageView.trailingAnchor, constant:  textImagePadding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 38),
            
            locationImageView.bottomAnchor.constraint(equalTo: avitarImageView.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: avitarImageView.trailingAnchor, constant:  textImagePadding),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),
            
            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor, constant:  0),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant:  5),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationLabel.heightAnchor.constraint(equalToConstant: 20),
            
            bioLabel.topAnchor.constraint(equalTo: avitarImageView.bottomAnchor,constant: textImagePadding),
            bioLabel.leadingAnchor.constraint(equalTo: avitarImageView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bioLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
   }
}
