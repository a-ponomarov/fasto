//
//  HistoryViewModel.swift
//  Fasto
//
//  Created by Andrii Ponomarov on 06.02.2023.
//

import Foundation
import CoreData

extension Fast {
    
    var interval: DateInterval? {
        guard let startDate = startDate,
              let endDate = endDate else { return nil }
        return DateInterval(start: startDate, end: endDate)
    }
}

@MainActor
class HistoryViewModel: ObservableObject {
    
    @Published var detailViewModel: DetailsViewModel?
    
    private var fasts: [Fast] = [] {
        didSet {
            let startDate = fasts.first?.startDate ?? Date()
            periodDateInterval = DateInterval(start: startDate, end: Date())
        }
    }
    
    private let repository: CoreDataRepository<Fast>
    
    init(repository: CoreDataRepository<Fast>) {
        self.repository = repository
    }
    
    @Published var periodDateInterval = DateInterval()
    
    func fast(date: Date) -> Fast? {
        return fasts.first { fast in
            guard let interval = fast.interval else { return false }
            let contains = date >= interval.start && date <= interval.end
            let inSameDayAsStart = date.inSameDay(interval.start)
            let inSameDayAsEnd = date.inSameDay(interval.end)
            return contains || inSameDayAsStart || inSameDayAsEnd
        }
    }
    
    func didSelectDate(date: Date) {
        guard let startDate = fast(date: date)?.startDate else { return }
        let predicate = NSPredicate(format: Constants.startDatePredicate, startDate as CVarArg)
        guard let selectedFast = repository.get(predicate: predicate).first else { return }
        detailViewModel = DetailsViewModel(fast: selectedFast, repository: repository) {
            self.onAppear()
        }
    }
    
    func onAppear() {
        fasts = repository.get(sortDescriptors:
                                [NSSortDescriptor(key: Constants.startDateKey,
                                                  ascending: true)]
        )
    }
    
}
