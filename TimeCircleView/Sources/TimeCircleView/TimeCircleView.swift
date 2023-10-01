//
//  TimeCircleView.swift
//
//
//  Created by Andrii Ponomarov on 15.02.2023.
//

import SwiftUI
import Foundation

public struct TimeCircleView: View {
    
    let title: String
    let backgroundColor: Color
    
    private let duration: Int
    private let sinceDate: Date
    private let isActive: Bool
    
    private let timer = Timer
        .publish(every: 1, on: .main, in: .common)
        .autoconnect()
        .prepend(Date())
    
    @State private var arcs: [Arc] = []
    @State private var progressarcs: [Arc] = []
    @State private var time: String = Constants.zeroTime
    
    public init(title: String,
                isActive: Bool,
                backgroundColor: Color,
                sinceDate: Date,
                duration: Int) {
        self.title = title
        self.isActive = isActive
        self.backgroundColor = backgroundColor
        self.sinceDate = sinceDate
        self.duration = duration
    }
    
    public var body: some View {
        GeometryReader { proxy in
            let size = min(proxy.size.width, proxy.size.height)
            ZStack {
                let lineWidth = size * 0.035
                ForEach(arcs) { arc in
                    ArcShape(model: arc, lineWidth: lineWidth)
                        .rotation(Angle(degrees: Constants.rotationDegree))
                        .stroke(backgroundColor, lineWidth: lineWidth)
                }
                ForEach(progressarcs) { arc in
                    ArcShape(model: arc, lineWidth: lineWidth)
                        .rotation(Angle(degrees: Constants.rotationDegree))
                        .stroke(Color.yellow, lineWidth: lineWidth)
                }
                VStack {
                    Text(title)
                        .font(.system(size: size * 0.08))
                    Text(time)
                        .font(.system(size: size * 0.13))
                        .bold()
                }
            }.onReceive(timer) { date in
                arcs = date.arcs(sinceDate: Date().addingTimeInterval(-Double(duration * 3600)), duration: duration)
                progressarcs = isActive ? date.arcs(sinceDate: sinceDate, duration: duration) : []
                time = isActive ? date.time(sinceDate: sinceDate) : Constants.zeroTime
            }
        }
    }
    
    private enum Constants {
        static let zeroTime = "00:00:00"
        static let rotationDegree: Double = -90
    }
    
}

struct TimeCircleView_Previews: PreviewProvider {
    static var previews: some View {
        TimeCircleView(title: "You are fasting",
                       isActive: true,
                       backgroundColor: .yellow,
                       sinceDate: Date().addingTimeInterval(-180000),
                       duration: 128)
    }
}
