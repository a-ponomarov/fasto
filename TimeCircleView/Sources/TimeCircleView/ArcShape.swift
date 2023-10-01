//
//  ArcShape.swift
//  
//
//  Created by Andrii Ponomarov on 15.02.2023.
//

import Foundation
import SwiftUI

struct ArcShape: Shape {
    
    let model: Arc
    let lineWidth: CGFloat

    func path(in rect: CGRect) -> Path {
        let diameter = min(rect.size.width, rect.size.height) - 2 * lineWidth
        let center = CGPoint(x: rect.midX, y: rect.midY)
        return Path { path in
            path.addArc(center: center,
                        radius: diameter / 2,
                        startAngle: Angle(degrees: model.startDegree),
                        endAngle: Angle(degrees: model.endDegree),
                        clockwise: false)
        }
    }
    
}
