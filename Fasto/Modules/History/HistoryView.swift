//
//  HistoryView.swift
//  Fasto
//
//  Created by Andrii Ponomarov on 21.11.2022.
//

import SwiftUI
import CalendarView

struct HistoryView: View {
    
    @StateObject private var viewModel = HistoryViewModel()
    
    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width / CGFloat(Constants.daysInWeek)
            CalendarView(interval: $viewModel.periodDateInterval) { date in
                VStack {
                    Text("\(date.day)")
                    if let interval = viewModel.fast(date: date)?.interval {
                        LineView(date: date,
                                 dateInterval: interval)
                            .frame(height: lineHeight)
                    } else {
                        EmptyView()
                    }
                    Spacer()
                }
                .frame(width: width, height: dayHeight)
                .onTapGesture {
                    viewModel.didSelectDate(date: date)
                }
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
    private let lineHeight: CGFloat = 13
    
}

struct HistoryCalendar_Previews: PreviewProvider {
    
    static var previews: some View {
        HistoryView()
    }
    
}
