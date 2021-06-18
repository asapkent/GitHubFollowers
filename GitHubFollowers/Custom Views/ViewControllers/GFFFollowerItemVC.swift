//
//  GFFFollowerItemVC.swift
//  GitHubFollowers
//
//  Created by Robert Jeffers on 5/25/21.
//  Copyright © 2021 AsapInc. All rights reserved.
//

import Foundation
import UIKit

class GFFFollowerItemVC: GFItemInfoVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoView1.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoView2.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(with: user)
    }
}
