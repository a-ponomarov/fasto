//
//  DateExtension.swift
//  
//
//  Created by Andrii Ponomarov on 15.02.2023.
//

import Foundation

extension Date {
    
    func seconds(_ sinceDate: Date) -> Int { Int(timeIntervalSince1970 - sinceDate.timeIntervalSince1970) }
    
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
    
    func arcs(duration: Int) -> [Arc] {
        arcs(sinceDate: minus(hours: duration), duration: duration)
    }
    
    func minus(hours: Int) -> Date { addingTimeInterval(-Double(hours * Constants.secondsInHour)) }
    
}

private enum Constants {
    static let hoursInDay: Int = 24
    static let secondsInHour: Int = 3600
    static let deegreesInCircle: Double = 360.0
}
