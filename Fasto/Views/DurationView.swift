//
//  DurationView.swift
//  Fasto
//
//  Created by Andrii Ponomarov on 12.10.2022.
//

import SwiftUI

struct DurationView: View {
    
    enum Index: Int {
        case days = 0
        case hours = 2
    }
    
    @Binding var duration: Int
    
    @State private var selections: [Int] = [0, 0, 0, 0]
    
    private var days: Int {
        selections[Index.days.rawValue]
    }
    
    private var hours: Int {
        selections[Index.hours.rawValue]
    }

    var body: some View {
        ZStack {
            PickerView(data: Constant.data,
                       widths: Constant.widths,
                       selections: $selections)
                
        }
        .onChange(of: selections) { selection in
            if days == 0 && hours == 0 {
                selections[Index.hours.rawValue] = 1
            }
            duration = days * Constants.hoursInDay + hours
        }
        .onAppear {
            guard let days = Constant.days.firstIndex(of: String(duration / Constants.hoursInDay)),
                  let hours = Constant.hours.firstIndex(of: String(duration % Constants.hoursInDay))
            else { return }
            selections = [days, 0, hours, 0]
        }
    }
    
    private enum Constant {
        static let days = Array(0...Constants.maxDurationInDays).map { $0.description }
        static let hours = Array(0...Constants.hoursInDay).map { $0.description }
        static let data = [Constant.days, [Strings.days.localized],
                           Constant.hours, [Strings.hours.localized]]
        static let widths: [Float] = [0.15, 0.22, 0.15, 0.3]
    }

}

struct DurationView_Previews: PreviewProvider {
    
    @State static private var duration = 128
    
    static var previews: some View {
        DurationView(duration: $duration)
    }
}
