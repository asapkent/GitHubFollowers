//
//  ErrorMessage.swift
//  GitHubFollowers
//
//  Created by Robert Jeffers on 7/6/20.
//  Copyright © 2020 AsapInc. All rights reserved.
//

import Foundation

enum GFError: String, Error {
    case invalidUsername = "This user name created an invalied request. Please try again."
    case unbableToComplete = "Unable to complete request. Please check your internet connection."
    case invalidResponse = "invalid response from server. Please try again."
    case invalidData = "Data from server is invailed. Please try again."
}
