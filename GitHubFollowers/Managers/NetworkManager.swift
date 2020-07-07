//
//  NetworkManger.swift
//  GitHubFollowers
//
//  Created by Robert Jeffers on 7/6/20.
//  Copyright © 2020 AsapInc. All rights reserved.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    let baseURL = "https://api.github.com/users/"
    
    private init() {}
    
    func getFollowers(for username: String, page: Int, completed: @escaping ([Follower]?, String?) -> Void) {
        let endPoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        
        
        guard let url = URL(string: endPoint) else {
            completed(nil, "This username did not retunr anything. Please try again.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(nil, "Unable to complete request. Please check internet connection.")
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, "Invailed response from server. Please try again.")
                return
            }
            
            guard let data = data else {
                completed(nil, "Data from server is invailed. Please try again.")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(followers, nil)
            } catch {
               completed(nil, "Data from server is invailed. Please try again.")
            }
        }
        
        task.resume()
    }
}
