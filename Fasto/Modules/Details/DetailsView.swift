//
//  DetailsView.swift
//  Fasto
//
//  Created by Andrii Ponomarov on 13.02.2023.
//

import SwiftUI
import TimeCircleView

struct DetailsView: View {
    
    @EnvironmentObject var viewModel: DetailsViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            HStack {
                Button { action(action: .cancel) } label: {
                    Text(Strings.cancel.localized)
                }
                Spacer()
                Button { action(action: .update) } label: {
                    Text(Strings.update.localized)
                }
            }
            .frame(height: Constants.buttonHeight)
            
            TimeCircleView(startDate: viewModel.startDate,
                           currentDate: Date(),
                           hours: viewModel.time)
            .frame(minWidth: 220, minHeight: 220)

            Spacer()
            
            TitleDatePicker(title: Strings.startDate.localized,
                            selection: $viewModel.startDate)
            TitleDatePicker(title: Strings.finishDate.localized,
                            selection: $viewModel.endDate)
            
            Button { action(action: .delete) } label: {
                Text(Strings.delete.localized)
                    .foregroundColor(.red)
            }
            .frame(height: Constants.buttonHeight)
        }.padding()
    }
    
    enum Constants {
        static let buttonHeight: CGFloat = 40
    }
    
    @MainActor
    private func action(action: Action) {
        switch action {
        case .update:
            viewModel.save()
        case .delete:
            viewModel.delete()
        default:
            break
        }
        dismiss()
    }
    
    private enum Action {
        case delete, update, cancel
    }
    
}
