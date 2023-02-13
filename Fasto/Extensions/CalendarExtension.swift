//
//  CalendarExtension.swift
//  Fasto
//
//  Created by Andrii Ponomarov on 09.02.2023.
//

import Foundation

extension Calendar {
    
    func generateDates(inside interval: DateInterval,
                               matching components: DateComponents) -> [Date] {
        var dates: [Date] = [interval.start]

        enumerateDates(startingAfter: interval.start,
                       matching: components,
                       matchingPolicy: .nextTime) { date, _, stop in
            guard let date, date < interval.end else { stop = true; return }
            dates.append(date)
        }

        return dates
    }

}
