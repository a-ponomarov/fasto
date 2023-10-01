//
//  DurationView.swift
//  Fasto
//
//  Created by Andrii Ponomarov on 12.10.2022.
//

import SwiftUI

struct DurationView: View {
    let width: CGFloat
    @Binding var duration: Int
    @State var hours: Float = 1
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        Slider(value: $hours, in: 1...168)
            .onChange(of: hours) { newValue in
                duration = Int(newValue)
            }.onAppear {
                hours = Float(duration)
            }
            .frame(width: width)
        Button("Done") {
            dismiss()
        }
    }
    

}
