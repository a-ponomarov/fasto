//
//  TitleDatePicker.swift
//  Fasto
//
//  Created by Andrii Ponomarov on 13.02.2023.
//

import SwiftUI

struct TitleDatePicker: View {
    
    let title: String
    
    @Binding var selection: Date
    
    var body: some View {
        HStack {
            Text(title)
            DatePicker("", selection: $selection)
                .datePickerStyle(.compact)
        }
    }
}

struct TitleDatePicker_Previews: PreviewProvider {
    
    @State static var selection = Date()
    
    static var previews: some View {
        TitleDatePicker(title: "", selection: $selection)
    }
}
