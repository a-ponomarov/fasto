//
//  DateFormatterExtension.swift
//  Fasto
//
//  Created by Andrii Ponomarov on 06.02.2023.
//

import Foundation

extension DateFormatter {
    
    static let monthAndYear: DateFormatter = {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("MMM yyyy")
        return formatter
    }()
    
    static let shortStyle: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
}
