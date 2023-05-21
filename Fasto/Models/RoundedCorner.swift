//
//  RoundedCorner.swift
//  Fasto
//
//  Created by Andrii Ponomarov on 21.05.2023.
//

import SwiftUI

struct RoundedCorner: Shape {
    let radius: CGFloat
    let corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
