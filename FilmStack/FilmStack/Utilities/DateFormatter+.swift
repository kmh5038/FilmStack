//
//  DateFormatter.swift
//  FilmStack
//
//  Created by 김명현 on 10/19/24.
//

import Foundation

extension DateFormatter {
    static func yesterdayString() -> String {
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        return dateFormatter.string(from: yesterday)
    }
}
