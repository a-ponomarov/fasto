//
//  FastViewModel.swift
//  Fasto
//
//  Created by Andrii Ponomarov on 11.10.2022.
//

import Foundation

@MainActor
class FastViewModel: ObservableObject {
    
    @Published var presentDuration = false
    @Published var presentDatePicker = false
    
    @Published var actionButtonText: String = Strings.start.localized
    @Published var actionText: String = Strings.startFast.localized
    
    @Published var endDate: Date
    
    @Published var startDate: Date {
        didSet {
            if startDate > Date() { startDate = Date() }
            endDate = startDate.addHours(duration)
            fast?.startDate = startDate
        }
    }
    
    @Published var duration: Int = Constants.intermittentFastDuration {
        didSet {
            let newEndDate = startDate.addHours(duration)
            guard endDate != newEndDate else { return }
            endDate = newEndDate
        }
    }
    
    @Published var isActive = false {
        didSet {
            isActive ? start() : end()
            actionText = isActive ? Strings.elapsedTime.localized : Strings.startFast.localized
            actionButtonText = isActive ? Strings.stop.localized : Strings.start.localized
        }
    }
    
    private var fast: Fast?
    
    private let repository: CoreDataRepository<Fast>
    
    init(repository: CoreDataRepository<Fast>,
         startDate: Date = Date(),
         endDate: Date = Date()) {
        self.repository = repository
        self.startDate = startDate
        self.endDate = endDate
    }
    
    func restore() {
        guard fast == nil else { return }
        let predicate = NSPredicate(format: Constants.notFinishedPredicate)
        fast = repository.get(predicate: predicate).last
        
        guard let fast else { return }
        startDate = fast.startDate ?? Date()
        duration = Int(fast.estimatedDuration)
        isActive = true
    }
    
    private func start() {
        guard fast == nil else { return }
        startDate = Date()
        let fast = repository.create()
        fast.startDate = startDate
        fast.estimatedDuration = Int32(duration)
        repository.save()
        self.fast = fast
    }
    
    private func end() {
        guard let fast, let startDate = fast.startDate else { return }
        let endDate = Date()
        let secondsDuration = Int(endDate.timeIntervalSince(startDate))
        if secondsDuration > Constants.secondsInHour {
            fast.endDate = endDate
        } else {
            repository.delete(entity: fast)
        }
        repository.save()
        self.fast = nil
    }
    
}
