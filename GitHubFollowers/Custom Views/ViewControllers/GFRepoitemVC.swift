//
//  GFRepoitemVC.swift
//  GitHubFollowers
//
//  Created by Robert Jeffers on 5/25/21.
//  Copyright © 2021 AsapInc. All rights reserved.
//

import Foundation
import UIKit

class GFRepoItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoView1.set(itemInfoType: .repos, withCount: user.publicRepos!)
        itemInfoView2.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGitHubProfile(with: user)
    }
}
