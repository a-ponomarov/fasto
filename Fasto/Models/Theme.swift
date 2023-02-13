//
//  Theme.swift
//  Fasto
//
//  Created by Andrii Ponomarov on 11.10.2022.
//

import SwiftUI

enum Theme: String, CaseIterable, Identifiable, Codable {
    
    case background
    
    var color: Color {
        Color(rawValue)
    }
    
    var name: String {
        rawValue.capitalized
    }
    
    var id: String {
        name
    }
    
}
