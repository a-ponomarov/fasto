//
//  DateExtension.swift
//  Fasto
//
//  Created by Andrii Ponomarov on 13.01.2023.
//

import Foundation

extension Date {
    
    var day: Int {
        Calendar.current.dateComponents([.day], from: self).day ?? 0
    }
    
    var seconds: Int {
        let components = Calendar.current.dateComponents([.hour, .minute, .second],
                                                         from: self)
        let second = components.second ?? 0
        let minute = components.minute ?? 0
        let hour = components.hour ?? 0
        let seconds = second + hour * Constants.secondsInHour +
                             minute * Constants.secondsInMinute
        return seconds
    }
    
    func hours(sinceDate: Date) -> Int {
        let elapsedSeconds = Int(timeIntervalSince1970 - sinceDate.timeIntervalSince1970)
        return elapsedSeconds / Constants.secondsInHour
    }
    
    func addHours(_ hours: Int) -> Date {
        return addingTimeInterval(TimeInterval(hours * Constants.secondsInHour))
    }
    
    func inSameDay(_ day: Date) -> Bool {
        Calendar.current.isDate(self, inSameDayAs: day)
    }
    
    func time(sinceDate: Date) -> String {
        let elapsedSeconds = Int(timeIntervalSince1970 - sinceDate.timeIntervalSince1970)
        let elapsedMinutes = elapsedSeconds / Constants.secondsInMinute
        let elapsedHours = elapsedSeconds / Constants.secondsInHour
        let remainedSeconds = elapsedSeconds % Constants.secondsInMinute
        let remainedMinutes = elapsedMinutes % Constants.minsInHour
        let seconds = remainedSeconds < Constants.firstTwoDigitNumber ? "0\(remainedSeconds)" : "\(remainedSeconds)"
        let minutes = remainedMinutes < Constants.firstTwoDigitNumber ? "0\(remainedMinutes)" : "\(remainedMinutes)"
        let hours = elapsedHours < Constants.firstTwoDigitNumber ? "0\(elapsedHours)" : "\(elapsedHours)"
        return "\(hours):\(minutes):\(seconds)"
    }
    
    private enum Constants {
        static let secondsInHour: Int = 3600
        static let secondsInMinute: Int = 60
        static let minsInHour: Int = 60
        static let firstTwoDigitNumber: Int = 10
    }
    
}
