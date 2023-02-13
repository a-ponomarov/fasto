//
//  DatePeriodView.swift
//  Fasto
//
//  Created by Andrii Ponomarov on 21.11.2022.
//

import SwiftUI

struct DatePeriodView: View {
    
    enum ActionType {
        case start, end
    }
    
    let startTitle: String
    let endTitle: String
    
    @Binding var startDate: Date
    @Binding var endDate: Date
    
    let action: ((ActionType) -> ())?
    
    var body: some View {
        HStack {
            Spacer()
            DatePeriodItemView(title: startTitle, date: $startDate)
                .onTapGesture { action?(.start) }
            Spacer()
            Spacer()
            DatePeriodItemView(title: endTitle, date: $endDate)
                .onTapGesture { action?(.end) }
            Spacer()
        }
    }
    
}

private struct DatePeriodItemView: View {
    
    let title: String
    
    @Binding var date: Date
    
    var body: some View {
        VStack {
            Text(title)
                .font(.system(size: Constants.fontSize, weight: .bold))
            Text(DateFormatter.shortStyle.string(from: date))
        }

    }
    
    private enum Constants {
        static let fontSize: CGFloat = 20
    }
}

struct DatePeriodView_Previews: PreviewProvider {
    
    @State static var startDate = Date()
    @State static var endDate = Date()
    
    static var previews: some View {
        DatePeriodView(startTitle: Strings.startDate.localized,
                       endTitle: Strings.goal.localized,
                       startDate: $startDate,
                       endDate: $endDate,
                       action: nil)
    }
}
