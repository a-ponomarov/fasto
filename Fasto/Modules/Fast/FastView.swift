//
//  CircleView.swift
//  Fasto
//
//  Created by Andrii Ponomarov on 11.10.2022.
//

import SwiftUI
import TimeCircleView

struct FastView: View {
    
    @StateObject private var viewModel = FastViewModel()
    
    var body: some View {
        VStack() {
            Spacer()
            TimeCircleView(startDate: viewModel.startDate, currentDate: viewModel.now, hours: viewModel.duration)
            .overlay {
                TimeText(title: viewModel.actionText, time: viewModel.time)
                DurationButtonView(duration: $viewModel.duration).onTapGesture { viewModel.presentDuration.toggle() }
            }
            
            if viewModel.isActive { DatePeriodView(viewModel: viewModel) }
            
            ActionButtonView(text: viewModel.actionButtonText).onTapGesture { viewModel.isActive.toggle() }
        }
        .onAppear { viewModel.restore() }
        .sheet(isPresented: $viewModel.presentDatePicker) {
            DatePickerView(startDate: $viewModel.startDate)
        }
        .sheet(isPresented: $viewModel.presentDuration) {
            DurationView(duration: $viewModel.duration).presentationDetents([.height(Constants.sheetHeight)])
        }
    }
    
    private enum Constants {
        static let sheetHeight: CGFloat = 210
    }
    
}

struct FastView_Previews: PreviewProvider {
    
    static var previews: some View {
        FastView()
    }
}


struct TimeText: View {
    
    let title: String
    let time: String
    
    var body: some View {
        VStack {
            Text(title)
            Text(time).bold()
        }
    }
    
}
