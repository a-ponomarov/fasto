//
//  DateExtension.swift
//  
//
//  Created by Andrii Ponomarov on 15.02.2023.
//

import Foundation

extension Date {
    
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

private enum Constants {
    static let hoursInDay: Int = 24
    static let secondsInHour: Int = 3600
    static let deegreesInCircle: Double = 360.0
    static let secondsInMinute: Int = 60
    static let minsInHour: Int = 60
    static let firstTwoDigitNumber: Int = 10
}
