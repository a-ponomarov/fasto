//
//  TimeCircleView.swift
//
//
//  Created by Andrii Ponomarov on 15.02.2023.
//

import SwiftUI
import Foundation

public struct TimeCircleView: View {
    
    private let arcs: [Arc]
    private let progressArcs: [Arc]

    public init(startDate: Date, currentDate: Date, hours: Int) {
        arcs = currentDate.arcs(duration: hours)
        progressArcs = currentDate.arcs(sinceDate: startDate, duration: hours)
    }
    
    public var body: some View {
        GeometryReader { proxy in
            let size = min(proxy.size.width, proxy.size.height)
            ZStack {
                let lineWidth = size * 0.035
                ForEach(arcs) { arc in
                    ArcShape(model: arc, lineWidth: lineWidth)
                        .rotation(Angle(degrees: Constants.rotationDegree))
                        .stroke(.white, lineWidth: lineWidth)
                }
                ForEach(progressArcs) { arc in
                    ArcShape(model: arc, lineWidth: lineWidth)
                        .rotation(Angle(degrees: Constants.rotationDegree))
                        .stroke(Color.yellow, lineWidth: lineWidth)
                }
            }
        }
    }
    
    private enum Constants {
        static let rotationDegree: Double = -90
    }
    
}
