//
//  NumberFormatter+.swift
//  FilmStack
//
//  Created by 김명현 on 10/19/24.
//

import Foundation

extension NumberFormatter {
    static let decimal: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    static func formatNumber(_ string: String) -> String {
        guard let number = Int(string) else {
            return string
        }
        let result = decimal.string(from: NSNumber(value: number)) ?? string
        
        return result
    }
}
