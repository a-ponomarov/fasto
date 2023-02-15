//
//  Constants.swift
//  Fasto
//
//  Created by Andrii Ponomarov on 16.11.2022.
//

import Foundation

enum Constants {
    static let hoursInDay: Int = 24
    static let daysInWeek: Int = 7
    static let secondsInHour: Int = 3600
    static let secondsInDay: Int = secondsInHour * 24
    static let secondsInMinute: Int = 60
    static let minsInHour: Int = 60
    static let maxDurationInDays: Int = 8
    static let intermittentFastDuration: Int = 16
    
    static let notFinishedPredicate = "endDate == nil"
    static let startDatePredicate = "startDate == %@"
}
