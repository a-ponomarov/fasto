//
//  HistoryView.swift
//  Fasto
//
//  Created by Andrii Ponomarov on 21.11.2022.
//

import SwiftUI

struct HistoryView: View {
    
    @EnvironmentObject var viewModel: HistoryViewModel
    
    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width / CGFloat(Constants.daysInWeek)
            CalendarView(interval: $viewModel.dateInterval) { date in
                ZStack {
                    DateView(date: date,
                            interval: viewModel.interval(date: date))
                        .frame(height: dayHeight)
                        .onTapGesture {
                            viewModel.didSelectDate(date: date)
                        }
                }.frame(width: width)
            }.onAppear {
                viewModel.onAppear()
            }
            .sheet(item: $viewModel.detailViewModel) { detailViewModel in
                DetailsView().environmentObject(detailViewModel)
            }
        }
        .padding()
    }
    
    private let dayHeight: CGFloat = 55
    
}

struct HistoryCalendar_Previews: PreviewProvider {
    
    static var previews: some View {
        HistoryView().environmentObject(HistoryViewModel(repository: CoreDataRepository<Fast>(managedObjectContext: PersistenceController().viewContext)))
    }
}
