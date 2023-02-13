//
//  ActionButtonView.swift
//  Fasto
//
//  Created by Andrii Ponomarov on 21.11.2022.
//

import SwiftUI

struct ActionButtonView: View {
    
    @Binding var title: String
    
    var body: some View {
        Text(title)
            .font(.system(size: Constants.fontSize, weight: .semibold))
            .frame(width: Constants.width, height: Constants.height)
            .background(Color.accentColor)
            .foregroundColor(.black)
            .cornerRadius(Constants.cornerRadius)
    }
    
    private enum Constants {
        static let fontSize: CGFloat = 28
        static let width: CGFloat = 330
        static let height: CGFloat = 55
        static let cornerRadius: CGFloat = 25
    }
    
}

struct ActionButtonView_Previews: PreviewProvider {
    
    @State static var title = "Action"
    
    static var previews: some View {
        ActionButtonView(title: $title)
    }
}
