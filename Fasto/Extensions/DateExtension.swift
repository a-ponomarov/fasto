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
    
    func addHours(_ hours: Int) -> Date {
        return addingTimeInterval(TimeInterval(hours * Constants.secondsInHour))
    }
    
    func inSameDay(_ day: Date) -> Bool {
        Calendar.current.isDate(self, inSameDayAs: day)
    }
    
    func seconds(_ sinceDate: Date) -> Int {
        return Int(timeIntervalSince1970 - sinceDate.timeIntervalSince1970)
    }
    
    func time(sinceDate: Date) -> String {
        let elapsedSeconds = seconds(sinceDate)
        let elapsedMinutes = elapsedSeconds / Constants.secondsInMinute
        let elapsedHours = elapsedSeconds / Constants.secondsInHour
        let remainedSeconds = elapsedSeconds % Constants.secondsInMinute
        let remainedMinutes = elapsedMinutes % Constants.minsInHour
        let seconds = remainedSeconds < Constants.firstTwoDigitNumber ? "0\(remainedSeconds)" : "\(remainedSeconds)"
        let minutes = remainedMinutes < Constants.firstTwoDigitNumber ? "0\(remainedMinutes)" : "\(remainedMinutes)"
        let hours = elapsedHours < Constants.firstTwoDigitNumber ? "0\(elapsedHours)" : "\(elapsedHours)"
        return "\(hours):\(minutes):\(seconds)"
    }
    
    func arcs(sinceDate: Date, duration: Int) -> [Arc] {
        let elapsedSeconds = seconds(sinceDate)
        let daysCount = duration / Constants.hoursInDay
        let daysHours = Array(repeatElement(Constants.hoursInDay, count: daysCount))
        let remainedHours = duration % Constants.hoursInDay
        let durations = remainedHours == 0 ? daysHours : daysHours + [remainedHours]
        let lengths = durations.map { Double($0) / Double(duration) }
        
        return durations.enumerated().map { index, hours in
            
            let deegree = Constants.deegreesInCircle * lengths[index]
            
            let secondsBefore = durations[0..<index].reduce(0) { $0 + $1 * Constants.secondsInHour }
            let secondsDuration = hours * Constants.secondsInHour
            let seconds = secondsBefore + secondsDuration
            
            let progress = elapsedSeconds >= seconds ? 1 :
            elapsedSeconds < secondsBefore ? 0 : Double(elapsedSeconds - secondsBefore) / Double(secondsDuration)
            
            let startDegree = 1 + Constants.deegreesInCircle * lengths[0..<index].reduce(0.0) { $0 + $1 }
            let endDegree = startDegree + deegree * progress - progress
            
            return Arc(startDegree: startDegree, endDegree: endDegree)
        }
    }
    
}
