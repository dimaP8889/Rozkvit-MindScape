//
//  Date+DateFormatter.swift
//  Rozkvit
//
//  Created by Dmytro Pogrebniak on 28.02.2024.
//

import Foundation

extension Date {
    private static let timeFormatter = { (format: DateTimeFormat) -> DateFormatter in
        let formatter = DateFormatter()
        formatter.dateFormat = format.formattedString
        return formatter
    }
    

    func formattedDate(by dateFormat: DateTimeFormat = .therapyEffectivnessTotal) -> String {
        Date.timeFormatter(dateFormat).string(from: self)
    }
}

enum DateTimeFormat {
    case therapyEffectivnessByDay
    case therapyEffectivnessTotal

    var formattedString: String {
        switch self {
        case .therapyEffectivnessByDay: return "dd.MM"
        case .therapyEffectivnessTotal: return "dd.MM hh:mm"
        }
    }
}
