//
//  GFAvatarImageView.swift
//  GitHubFollowers
//
//  Created by Robert Jeffers on 7/11/20.
//  Copyright © 2020 AsapInc. All rights reserved.
//

import UIKit

class GFAvatarImageView: UIImageView {
    // only force unwrapping becasue we know it is in our assests, if this was an image from web no force unwrapping
    let placeholderImage = UIImage(named: "avatar-placeholder")!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
}
