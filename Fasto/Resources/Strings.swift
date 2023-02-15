//
//  Strings.swift
//  Fasto
//
//  Created by Andrii Ponomarov on 12.10.2022.
//

import Foundation

enum Strings: String {
    case startFast = "Start your fast now!"
    case elapsedTime = "Elapsed Time"
    case startDate = "START DATE"
    case finishDate = "FINISH DATE"
    case cancel = "Cancel"
    case goal = "GOAL"
    case start = "Start"
    case stop = "Stop"
    case delete = "Delete"
    case update = "Update"
    case today = "Today"
    case history = "History"
    case days
    case hours
    case shortHours = "%@h"
    
    var localized: String {
        String(localized: String.LocalizationValue(rawValue))
    }
    
}
