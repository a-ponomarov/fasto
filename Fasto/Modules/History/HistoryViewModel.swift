//
//  HistoryViewModel.swift
//  Fasto
//
//  Created by Andrii Ponomarov on 06.02.2023.
//

import Foundation
import CoreData

@MainActor
class HistoryViewModel: ObservableObject {
    
    private var intervals: [DateInterval] = []
    
    private let repository: CoreDataRepository<Fast>
    
    init(repository: CoreDataRepository<Fast>) {
        self.repository = repository
    }
    
    @Published var dateInterval = DateInterval()
    
    func interval(date: Date) -> DateInterval? {
        return intervals.first { interval in
            interval.contains(date) ||
            date.inSameDay(interval.start) ||
            date.inSameDay(interval.end)
        }
    }
    
    func onAppear() {
        intervals = repository.get()
            .map { DateInterval(start: $0.startDate ?? Date(), end: $0.endDate ?? Date()) }
            .sorted { $0.start < $1.start }
        if let start = intervals.first?.start {
            dateInterval = DateInterval(start: start,
                                        end: Date())
        }
        
    }
}
