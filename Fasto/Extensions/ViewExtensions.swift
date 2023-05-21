//
//  ViewExtensions.swift
//  Fasto
//
//  Created by Andrii Ponomarov on 21.05.2023.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
