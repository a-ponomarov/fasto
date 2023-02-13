//
//  CircleView.swift
//  Fasto
//
//  Created by Andrii Ponomarov on 11.10.2022.
//

import SwiftUI

struct FastView: View {
    
    @EnvironmentObject var viewModel: FastViewModel
    
    var body: some View {
        ZStack() {
            VStack() {
                Spacer()
                ZStack {
                    DurationButtonView(duration: $viewModel.duration)
                        .onTapGesture { viewModel.presentDuration.toggle() }
                    CircleProgressView(arcs: $viewModel.arcs)
                    VStack {
                        Text(viewModel.actionText)
                            .font(.system(size: Constants.actionTextFontSize))
                        Text(viewModel.timeText)
                            .font(.system(size: Constants.timeTextFontSize))
                            .bold()
                    }
                }
                PeriodView.padding(.bottom)
                ActionButtonView(title: $viewModel.actionButtonText)
                    .onTapGesture { viewModel.isActive.toggle() }
            }.padding()
        }
        .onAppear {
            viewModel.restore()
        }
        .sheet(isPresented: $viewModel.presentDuration) {
            DurationView(duration: $viewModel.duration)
                //.presentationDetents([.height(Constants.sheetHeight)])
        }
        .sheet(isPresented: $viewModel.presentDatePicker) {
            DatePicker(String(),
                       selection: $viewModel.startDate)
                .datePickerStyle(.graphical)
        }
    }
    
    var PeriodView: some View {
        ZStack {
            let periodView = DatePeriodView(startTitle: Strings.startDate.localized,
                                            endTitle: Strings.goal.localized,
                                            startDate: $viewModel.startDate,
                                            endDate: $viewModel.endDate) {
                switch $0 {
                case .start:
                    viewModel.presentDatePicker = true
                case .end:
                    viewModel.presentDuration = true
                }
                
            }
            if viewModel.isActive {
                periodView
            } else {
                periodView.hidden()
            }
        }
    }
    
    private enum Constants {
        static let actionTextFontSize: CGFloat = 22
        static let timeTextFontSize: CGFloat = 44
        static let sheetHeight: CGFloat = 210
    }
    
}

struct FastView_Previews: PreviewProvider {
    
    @StateObject private static var viewModel = FastViewModel(repository: CoreDataRepository<Fast>(managedObjectContext: PersistenceController().viewContext))
    
    static var previews: some View {
        FastView().environmentObject(viewModel)
    }
}
