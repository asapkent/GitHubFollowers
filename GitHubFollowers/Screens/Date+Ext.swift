//
//  Date+Ext.swift
//  GitHubFollowers
//
//  Created by Robert Jeffers on 6/5/21.
//  Copyright © 2021 AsapInc. All rights reserved.
//

import Foundation

extension Date {
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        
        return dateFormatter.string(from: self)
    }
}
