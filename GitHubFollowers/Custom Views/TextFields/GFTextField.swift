//
//  GFTextField.swift
//  GitHubFollowers
//
//  Created by Robert Jeffers on 7/5/20.
//  Copyright © 2020 AsapInc. All rights reserved.
//

import UIKit

class GFTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor
        
        textColor = .label
        // curser color
        tintColor = .label
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        
        returnKeyType = .go
        backgroundColor = .systemBackground
        autocorrectionType = .no
        placeholder = "User Name"
    }
    
}
