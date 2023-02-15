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
    
    @Published var detailViewModel: DetailsViewModel?
    
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
    
    func didSelectDate(date: Date) {
        guard let startDate = interval(date: date)?.start else { return }
        let predicate = NSPredicate(format: Constants.startDatePredicate,
                                    startDate as CVarArg)
        if let selectedFast = repository.get(predicate: predicate).first {
            detailViewModel = DetailsViewModel(fast: selectedFast, repository: repository) {
                self.onAppear()
            }
        }
    }
    
    func onAppear() {
        intervals = repository.get()
            .compactMap {
                guard let startDate = $0.startDate,
                      let endDate = $0.endDate else { return nil }
                return DateInterval(start: startDate, end: endDate)
            }
            .sorted { $0.start < $1.start }
        dateInterval = DateInterval(start: intervals.first?.start ?? Date(),
                                    end: Date())
        
    }
    
}
