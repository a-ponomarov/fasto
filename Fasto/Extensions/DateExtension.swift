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
    
}
