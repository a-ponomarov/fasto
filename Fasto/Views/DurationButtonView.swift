//
//  DurationButtonView.swift
//  Fasto
//
//  Created by Andrii Ponomarov on 21.11.2022.
//

import SwiftUI

struct DurationButtonView: View {
    
    @Binding var duration: Int
    
    var body: some View {
        GeometryReader { reader in
            HStack() {
                Spacer()
                Capsule()
                    .foregroundColor(Color.green)
                    .frame(width: Constants.width, height: Constants.height)
                    .overlay {
                        Text(String(format: Strings.shortHours.localized, duration.description))
                            .foregroundColor(.black)
                            .font(.system(size: Constants.fontSize,
                                          weight: .bold))
                    }
                    .padding(.top, Constants.padding)
            }
        }
    }
    
    private enum Constants {
        static let padding: CGFloat = 8
        static let fontSize: CGFloat = 22
        static let width: CGFloat = 88
        static let height: CGFloat = 55
    }
}

struct DurationButtonView_Previews: PreviewProvider {
    
    @State static var duration: Int = 16
    
    static var previews: some View {
        DurationButtonView(duration: $duration)
    }
}
