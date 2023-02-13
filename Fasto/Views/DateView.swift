//
//  DateView.swift
//  Fasto
//
//  Created by Andrii Ponomarov on 21.11.2022.
//

import SwiftUI

struct DateView: View {
    
    let date: Date
    let interval: DateInterval?
    
    var body: some View {
        VStack(spacing: spacing) {
            Text("\(date.day)")
            if let interval {
                LineView(date: date,
                         dateInterval: interval)
                    .frame(height: lineHeight)
            }
            Spacer()
        }
    }
    
    private let lineHeight: CGFloat = 10
    private let spacing: CGFloat = 3
}

struct DateView_Previews: PreviewProvider {
    static var previews: some View {
        DateView(date: Date(), interval: nil)
    }
}
