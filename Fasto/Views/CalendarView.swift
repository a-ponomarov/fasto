//
//  CalendarView.swift
//  Fasto
//
//  Created by Andrii Ponomarov on 21.11.2022.
//

import SwiftUI

struct CalendarView<DateView: View>: View {
    
    @Binding var interval: DateInterval
    
    @Environment(\.calendar) private var calendar
    
    @State private var months: [Date] = []
    @State private var days: [Date: [Date]] = [:]
    
    let content: (Date) -> DateView
    
    private let spacing: CGFloat = 7
    private let padding: CGFloat = 33
    
    private let columns: [GridItem] = {
        return Array(repeating: GridItem(spacing: 0), count: Constants.daysInWeek)
    }()
    
    private func header(for month: Date) -> some View {
        Text(DateFormatter.monthAndYear.string(from: month)).padding(.top, padding)
    }

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, alignment: .trailing, spacing: spacing) {
                ForEach(months, id: \.self) { month in
                    Section(header: header(for: month)) {
                        ForEach(days[month, default: []], id: \.self) { date in
                            if calendar.isDate(date, equalTo: month, toGranularity: .month) {
                                content(date).id(date)
                            } else {
                                content(date).hidden()
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
