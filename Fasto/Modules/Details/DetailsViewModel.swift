//
//  DetailsViewModel.swift
//  Fasto
//
//  Created by Andrii Ponomarov on 13.02.2023.
//

import Foundation

@MainActor
class DetailsViewModel: ObservableObject, Identifiable {
    
    private let fast: Fast
    private let completion: (() -> ())?
    
    @Published var time: Int
    @Published var startDate: Date {
        didSet {
            if startDate > Date() { startDate = Date() }
            updateTime()
        }
    }
    @Published var endDate: Date {
        didSet {
            if endDate < startDate { endDate = startDate }
            updateTime()
        }
    }
    
    init(fast: Fast, completion: (() -> ())?) {
        self.fast = fast
        let startDate = fast.startDate ?? Date()
        let endDate = fast.endDate ?? Date()
        self.startDate = startDate
        self.endDate = endDate
        self.completion = completion
        self.time = endDate.hours(sinceDate: startDate)
    }
    
    func delete() {
        FastRepository.shared.delete(entity: fast)
        FastRepository.shared.save()
        completion?()
    }

    func save() {
        fast.startDate = startDate
        fast.endDate = endDate
        FastRepository.shared.save()
        completion?()
    }
    
    private func updateTime() {
        time = endDate.hours(sinceDate: startDate)
    }
    
}
