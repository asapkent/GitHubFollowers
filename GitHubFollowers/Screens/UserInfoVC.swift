//
//  UserInfoVC.swift
//  GitHubFollowers
//
//  Created by Robert Jeffers on 8/15/20.
//  Copyright © 2020 AsapInc. All rights reserved.
//

import UIKit

class UserInfoVC: UIViewController {
    
    let headerView = UIView()
    let itemView1 = UIView()
    let itemView2 = UIView()
    var itemViews: [UIView] = []
    
    var username: String!
    
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
                   self.addChildVC(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
               }
           case .failure(let error):
               self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
           }
       }
    }
    
    func layoutUI() {
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        itemViews = [headerView, itemView1, itemView2]
        
        // loop to add views and add constraints
        for itemViews in itemViews {
            view.addSubview(itemViews)
            itemViews.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemViews.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemViews.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
            
        }
    
        itemView1.backgroundColor = .systemPink
        itemView2.backgroundColor = .systemRed
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemView1.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemView1.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemView2.topAnchor.constraint(equalTo: itemView1.bottomAnchor, constant: padding),
            itemView2.heightAnchor.constraint(equalToConstant: itemHeight)
            
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
