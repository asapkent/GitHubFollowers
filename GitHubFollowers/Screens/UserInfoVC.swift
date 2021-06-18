//
//  UserInfoVC.swift
//  GitHubFollowers
//
//  Created by Robert Jeffers on 8/15/20.
//  Copyright © 2020 AsapInc. All rights reserved.
//

import UIKit

protocol UserInfoVCDelegate: AnyObject {
    func didTapGitHubProfile(with user: User)
    func didTapGetFollowers(with user: User)
}

class UserInfoVC: UIViewController {
    
    let headerView = UIView()
    let itemView1 = UIView()
    let itemView2 = UIView()
    let dateLabel = GFBodyLabel(textAlignment: .center)
    var itemViews: [UIView] = []
    
    var username: String!
    weak var delegate: FollowerListVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        layoutUI()
        getUserInfo()
       
    }
    
    func configureViewController() {
           view.backgroundColor = .systemBackground
           let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
           navigationItem.rightBarButtonItem = doneButton
    }
    
    func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] (result) in
           guard let self = self else { return }
           
           switch result {
           case .success(let user) :
               DispatchQueue.main.async {
                self.configureUIElements(with: user)
             }
           case .failure(let error):
               self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
           }
       }
    }
    
    func configureUIElements(with user: User) {
        self.addChildVC(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        
        let repoItemVC = GFRepoItemVC(user: user)
        repoItemVC.delegate = self
        
        let followerItemVC = GFFFollowerItemVC(user: user)
        followerItemVC.delegate = self
        
     self.addChildVC(childVC: repoItemVC, to: self.itemView1)
     self.addChildVC(childVC: followerItemVC, to: self.itemView2)
     self.dateLabel.text = "Git hub since: \(user.createdAt.convertToDisplayFormat())"
    }
    
    func layoutUI() {
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        itemViews = [headerView, itemView1, itemView2, dateLabel]
        
        // loop to add views and add constraints
        for itemViews in itemViews {
            view.addSubview(itemViews)
            itemViews.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemViews.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemViews.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
            
        }
    
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemView1.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemView1.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemView2.topAnchor.constraint(equalTo: itemView1.bottomAnchor, constant: padding),
            itemView2.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemView2.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
            
        ])
    }
    
    func addChildVC(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}

extension UserInfoVC: UserInfoVCDelegate {
    
    func didTapGitHubProfile(with user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(title: "Invalid URL", message: "The url attached to this user is invalid", buttonTitle: "Ok")
            return
        }
        presentSafariVC(with: url)
    }
    
    func didTapGetFollowers(with user: User) {
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(title: "No followers", message: "This user has no followers", buttonTitle: "Ok")
            return
        }
        delegate.didRequestFollowers(from: user.login)
        dismissVC()
    }
}
