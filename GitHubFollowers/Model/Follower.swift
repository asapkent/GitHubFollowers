//
//  Follower.swift
//  GitHubFollowers
//
//  Created by Robert Jeffers on 7/6/20.
//  Copyright © 2020 AsapInc. All rights reserved.
//

import Foundation

struct Follower: Codable, Hashable {
    var login: String
    var avatarUrl: String
}
