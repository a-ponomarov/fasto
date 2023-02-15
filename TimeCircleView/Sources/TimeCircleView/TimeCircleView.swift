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
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State private var arcs: [Arc] = []
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
        ZStack {
            Circle()
                .strokeBorder(lineWidth: Constants.borderLineWidth)
                .foregroundColor(backgroundColor)
                .shadow(radius: Constants.shadowRadius)
            ForEach(arcs) { arc in
                ArcShape(model: arc)
                    .rotation(Angle(degrees: Constants.rotationDegree))
                    .stroke(Color.accentColor, lineWidth: Constants.arcLineWidth)
            }
            VStack {
                Text(title)
                    .font(.system(size: Constants.titleFontSize))
                Text(time)
                    .font(.system(size: Constants.timeFontSize))
                    .bold()
            }
        }.onReceive(timer) { date in
            arcs = isActive ? date.arcs(sinceDate: sinceDate, duration: duration) : []
            time = isActive ? date.time(sinceDate: sinceDate) : Constants.zeroTime
        }
    }
    
    private enum Constants {
        static let zeroTime = "00:00:00"
        static let shadowRadius: CGFloat = 8
        static let borderLineWidth: CGFloat = 24
        static let arcLineWidth: CGFloat = 12
        static let rotationDegree: Double = -90
        static let titleFontSize: CGFloat = 22
        static let timeFontSize: CGFloat = 44
    }
    
}
