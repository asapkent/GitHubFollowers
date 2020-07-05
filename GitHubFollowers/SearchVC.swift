//
//  SearchVC.swift
//  GitHubFollowers
//
//  Created by Robert Jeffers on 7/5/20.
//  Copyright © 2020 AsapInc. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    let logoImageView = UIImageView()
    let usernameTextFeild = GFTextField()
    let button = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    // only gets called once
    override func viewDidLoad() {
        super.viewDidLoad()
        // dark mode black/light mode white
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureTextFeild()
        configureButton()
    }
    
    //gets called everytime
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "gh-logo")!
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureTextFeild() {
        view.addSubview(usernameTextFeild)
        
        NSLayoutConstraint.activate([
            usernameTextFeild.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextFeild.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextFeild.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextFeild.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    func configureButton() {
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}
