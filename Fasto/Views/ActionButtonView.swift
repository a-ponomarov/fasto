//
//  ActionButtonView.swift
//  Fasto
//
//  Created by Andrii Ponomarov on 25.11.2023.
//

import SwiftUI

struct ActionButtonView: View {
    
    let text: String
    
    enum Constants {
        static let height: CGFloat = 55
        static let fontSize: CGFloat = 28
        static let cornerRadius: CGFloat = height / 2
    }
    
    var body: some View {
        ZStack {
            Text(text)
                .font(.system(size: Constants.fontSize, weight: .semibold))
                .foregroundColor(.black)
                .padding()
        }
        .frame(height: Constants.height)
        .background(Color.accentColor)
        .cornerRadius(Constants.cornerRadius)
    }
    
}
