//
//  CircleView.swift
//  Fasto
//
//  Created by Andrii Ponomarov on 11.10.2022.
//

import SwiftUI
import TimeCircleView

struct FastView: View {
    
    @EnvironmentObject var viewModel: FastViewModel
    
    var body: some View {
        ZStack() {
            VStack() {
                Spacer()
                ZStack {
                    DurationButtonView(duration: $viewModel.duration)
                        .onTapGesture { viewModel.presentDuration.toggle() }
                    TimeCircleView(title: viewModel.actionText,
                                   isActive: viewModel.isActive,
                                   backgroundColor: Theme.background.color,
                                   sinceDate: viewModel.startDate,
                                   duration: viewModel.duration)
                }
                PeriodView.padding(.bottom)
                Button { viewModel.isActive.toggle() } label: {
                    Text(viewModel.actionButtonText)
                        .frame(width: Constants.Button.width, height: Constants.Button.height)
                        .font(.system(size: Constants.Button.fontSize, weight: .semibold))
                        .background(Color.accentColor)
                        .foregroundColor(.black)
                        .cornerRadius(Constants.Button.cornerRadius)
                }
            }.padding()
        }
        .onAppear {
            viewModel.restore()
        }
        .sheet(isPresented: $viewModel.presentDuration) {
            DurationView(duration: $viewModel.duration)
                .presentationDetents([.height(Constants.sheetHeight)])
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
        static let sheetHeight: CGFloat = 210
        
        enum Button {
            static let width: CGFloat = 330
            static let height: CGFloat = 55
            static let fontSize: CGFloat = 28
            static let cornerRadius: CGFloat = 25
        }
    }
    
}

struct FastView_Previews: PreviewProvider {
    
    @StateObject private static var viewModel = FastViewModel(repository: CoreDataRepository<Fast>(managedObjectContext: PersistenceController().viewContext))
    
    static var previews: some View {
        FastView().environmentObject(viewModel)
    }
}

