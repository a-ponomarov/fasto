//
//  CircleProgressView.swift
//  Fasto
//
//  Created by Andrii Ponomarov on 21.11.2022.
//

import SwiftUI

struct CircleProgressView: View {
    
    @Binding var arcs: [Arc]
    
    var body: some View {
        ZStack {
            Circle()
                .strokeBorder(lineWidth: Constants.borderLineWidth)
                .foregroundColor(Theme.background.color)
                .shadow(radius: Constants.shadowRadius)
            ForEach(arcs) { arc in
                ArcShape(model: arc)
                    .rotation(Angle(degrees: Constants.rotationDegree))
                    .stroke(Color.accentColor, lineWidth: Constants.arcLineWidth)
            }
        }
    }
    
    private enum Constants {
        static let shadowRadius: CGFloat = 8
        static let borderLineWidth: CGFloat = 24
        static let arcLineWidth: CGFloat = 12
        static let rotationDegree: Double = -90
    }
    
}

struct CircleProgressView_Previews: PreviewProvider {
    
    @State static var arcs: [Arc] = [Arc(startDegree: 0, endDegree: 90)]
    
    static var previews: some View {
        CircleProgressView(arcs: $arcs)
    }
}
