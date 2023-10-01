//
//  DatePickerView.swift
//  Fasto
//
//  Created by Andrii Ponomarov on 17.07.2023.
//

import SwiftUI

struct DatePickerView: View {
    @Binding var startDate: Date
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack {
            DatePicker(String(),
                       selection: $startDate)
                .datePickerStyle(.graphical)
            Button("Done") {
                dismiss()
            }
        }
        
    }
}

struct DatePickerView_Previews: PreviewProvider {
    @State static var startDate = Date()
    static var previews: some View {
        DatePickerView(startDate: $startDate)
    }
}
