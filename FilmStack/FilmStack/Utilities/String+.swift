//
//  String+.swift
//  FilmStack
//
//  Created by 김명현 on 10/19/24.
//

import Foundation

extension String {
    func addingSpaceBeforeNumbers() -> String {
        let pattern = "([a-zA-Z가-힣])([0-9])"
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(location: 0, length: self.utf16.count)
        return regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: "$1 $2")
    }
    
    func removingSpaceBeforeNumbers() -> String {
        return self.replacingOccurrences(of: " (?=\\d)", with: "", options: .regularExpression)
    }
}
