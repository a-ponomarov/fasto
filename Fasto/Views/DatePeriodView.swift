//
//  DatePeriodView.swift
//  Fasto
//
//  Created by Andrii Ponomarov on 21.11.2022.
//

import SwiftUI

struct DatePeriodView: View {
    
    @ObservedObject var viewModel: FastViewModel
    
    var body: some View {
        HStack {
            Spacer()
            DatePeriodItemView(title: Strings.startDate.localized, date: $viewModel.startDate)
                .onTapGesture { viewModel.presentDatePicker = true }
            Spacer()
            Spacer()
            DatePeriodItemView(title: Strings.goal.localized, date: $viewModel.endDate)
                .onTapGesture { viewModel.presentDuration = true }
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
