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
    let cache = NetworkManager.shared.cache
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
    
    func downloadImage(for urlString: String) {
        
        let cacheKey = NSString(string: urlString)
        
        // if we have the image already do not do network call again for image
        if let image = cache.object(forKey: cacheKey) {
            self.image = image
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            if error != nil { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            
            guard let image = UIImage(data: data) else { return }
            // set already downloaded images to cache
            self.cache.setObject(image, forKey: cacheKey)
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
        
        task.resume()
    }
}
