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
    
    @Published var time = String()
    
    @Published var actionButtonText: String = Strings.start.localized
    @Published var actionText: String = Strings.startFast.localized
    
    @Published var now = Date()
    
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
    private var timer: Timer?
    
    init(startDate: Date = Date(), endDate: Date = Date()) {
        self.startDate = startDate
        self.endDate = endDate
    }
    
    func restore() {
        guard fast == nil else { return }
        let predicate = NSPredicate(format: Constants.notFinishedPredicate)
        fast = FastRepository.shared.get(predicate: predicate).last
        
        guard let fast else { return }
        startDate = fast.startDate ?? Date()
        duration = Int(fast.estimatedDuration)
        isActive = true
        startTimer()
    }
    
    private func start() {
        guard fast == nil else { return }
        startDate = Date()
        let fast = FastRepository.shared.create()
        fast.startDate = startDate
        fast.estimatedDuration = Int32(duration)
        FastRepository.shared.save()
        self.fast = fast
        startTimer()
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(timerAction),
                                     userInfo: nil,
                                     repeats: true)
        timer?.fire()
    }
    
    @objc private func timerAction() {
        now = Date()
        time = isActive ? now.time(sinceDate: startDate) : .zeroTime
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func end() {
        guard let fast, let startDate = fast.startDate else { return }
        let endDate = Date()
        let secondsDuration = Int(endDate.timeIntervalSince(startDate))
        if secondsDuration > Constants.secondsInHour {
            fast.endDate = endDate
        } else {
            FastRepository.shared.delete(entity: fast)
        }
        FastRepository.shared.save()
        self.fast = nil
        time = .zeroTime
    }
    
}
