//
//  ArcShape.swift
//  Fasto
//
//  Created by Andrii Ponomarov on 11.10.2022.
//

import SwiftUI

struct Arc: Identifiable {
    let id = UUID()
    let startDegree: Double
    let endDegree: Double
}

struct ArcShape: Shape {
    
    let model: Arc

    func path(in rect: CGRect) -> Path {
        let diameter = min(rect.size.width, rect.size.height) - Constants.offset
        let radius = diameter / 2
        let center = CGPoint(x: rect.midX, y: rect.midY)
        
        return Path { path in
            path.addArc(center: center, radius: radius,
                        startAngle: Angle(degrees: model.startDegree),
                        endAngle: Angle(degrees: model.endDegree),
                        clockwise: false)
        }
    }
    
    private enum Constants {
        static let offset: CGFloat = 24
    }
    
}
