//
//  GFBodyLabel.swift
//  GitHubFollowers
//
//  Created by Robert Jeffers on 7/6/20.
//  Copyright © 2020 AsapInc. All rights reserved.
//

import UIKit

class GFBodyLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlignment: NSTextAlignment) {
         super.init(frame: .zero)
         self.textAlignment = textAlignment
         configure()
        }
     
     private func configure() {
         textColor = .secondaryLabel
        font = .preferredFont(forTextStyle: .body)
         adjustsFontSizeToFitWidth = true
         minimumScaleFactor = 0.75
         lineBreakMode = .byWordWrapping
         translatesAutoresizingMaskIntoConstraints = false
     }
    
}
