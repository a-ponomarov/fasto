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
        GeometryReader { proxy in
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
                    Text(viewModel.actionButtonText)
                        .frame(width: proxy.size.width * 0.88, height: Constants.Button.height)
                        .font(.system(size: Constants.Button.fontSize, weight: .semibold))
                        .background(Color.accentColor)
                        .foregroundColor(.black)
                        .cornerRadius(Constants.Button.cornerRadius)
                        .onTapGesture {
                            viewModel.isActive.toggle()
                        }
                }.padding()
            }
            .onAppear {
                viewModel.restore()
            }
            .sheet(isPresented: $viewModel.presentDuration) {
                DurationView(width: proxy.size.width,
                             duration: $viewModel.duration)
                    .presentationDetents([.height(Constants.sheetHeight)])
            }
            .sheet(isPresented: $viewModel.presentDatePicker) {
                DatePickerView(startDate: $viewModel.startDate)
            }
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
            static let height: CGFloat = 55
            static let fontSize: CGFloat = 28
            static let cornerRadius: CGFloat = height / 2
        }
    }
    
}

struct FastView_Previews: PreviewProvider {
    
    @StateObject private static var viewModel = FastViewModel(repository: CoreDataRepository<Fast>(managedObjectContext: PersistenceController().viewContext))
    
    static var previews: some View {
        FastView().environmentObject(viewModel)
    }
}

