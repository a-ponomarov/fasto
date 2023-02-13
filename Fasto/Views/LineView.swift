//
//  LineView.swift
//  Fasto
//
//  Created by Andrii Ponomarov on 21.11.2022.
//

import SwiftUI

struct LineView: View {
    
    private let x: CGFloat
    private let progress: CGFloat
    
    init(x: CGFloat, progress: CGFloat) {
        self.x = x
        self.progress = progress
    }
    
    init(date: Date, dateInterval: DateInterval) {
        let start = dateInterval.start
        let end = dateInterval.end
        let isStartDay = start.inSameDay(date)
        let isEndDay = end.inSameDay(date)
        let seconds = start.inSameDay(end) ? end.seconds - start.seconds :
        isStartDay ? Constants.secondsInDay - start.seconds :
        isEndDay ? end.seconds : Constants.secondsInDay
        progress = CGFloat(seconds) / CGFloat(Constants.secondsInDay)
        x = start.inSameDay(end) || isStartDay ?
        CGFloat(start.seconds) / CGFloat(Constants.secondsInDay) : 0
    }
    
    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width
            Color.accentColor
                .position(x: width * x + progress * width / 2,
                          y: proxy.size.height / 2)
                .frame(width: width * progress)
        }
    }
}

struct LineView_Previews: PreviewProvider {
    static var previews: some View {
        LineView(x: 0.25, progress: 0.5).frame(height: 50)
    }
}
