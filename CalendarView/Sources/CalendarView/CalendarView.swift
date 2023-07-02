//
//  CalendarView.swift
//  Fasto
//
//  Created by Andrii Ponomarov on 21.11.2022.
//

import SwiftUI

public struct CalendarView<DateView: View>: View {
    
    @Binding public var interval: DateInterval
    
    @Environment(\.calendar) private var calendar
    
    @State private var months: [Date] = []
    @State private var days: [Date: [Date]] = [:]
    
    public let content: (Date) -> DateView
    
    public init(interval: Binding<DateInterval>,
                content: @escaping (Date) -> DateView) {
        self._interval = interval
        self.content = content
    }
    
    private let spacing: CGFloat = 7
    private let padding: CGFloat = 33
    
    private let columns: [GridItem] = {
        return Array(repeating: GridItem(spacing: 0), count: Constants.daysInWeek)
    }()
    
    private func header(for month: Date) -> some View {
        Text(DateFormatter.monthAndYear.string(from: month)).padding(.top, padding)
    }

    public var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns, alignment: .trailing, spacing: spacing) {
                ForEach(months, id: \.self) { month in
                    Section(header: header(for: month)) {
                        ForEach(days[month, default: []], id: \.self) { date in
                            if calendar.isDate(date, equalTo: month, toGranularity: .month) {
                                content(date)
                            } else {
                                EmptyView()
                            }
                        }
                    }
                }
            }
        }
        .onChange(of: interval) { interval in
            generateDates(interval: interval)
        }
    }
    
    private func generateDates(interval: DateInterval) {
        months = calendar.generateDates(inside: interval,
                                        matching: DateComponents(day: 1, hour: 0, minute: 0, second: 0))
        
        days = months.reduce(into: [:]) { current, month in
            guard
                let monthInterval = calendar.dateInterval(of: .month, for: month),
                let monthFirstWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.start),
                let monthLastWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.end)
            else { return }
            
            let inside = DateInterval(start: monthFirstWeek.start, end: monthLastWeek.end)
            let matching = DateComponents(hour: 0, minute: 0, second: 0)
            current[month] = calendar.generateDates(inside: inside, matching: matching)
        }
    }

}

private enum Constants {
    static let daysInWeek = 7
}

private extension Calendar {
    
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

private extension DateFormatter {
    
    static let monthAndYear: DateFormatter = {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("MMM yyyy")
        return formatter
    }()
    
}
