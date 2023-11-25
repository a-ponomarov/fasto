//
//  TabBarView.swift
//  Fasto
//
//  Created by Andrii Ponomarov on 06.02.2023.
//

import SwiftUI

struct TabBarView: View {
    
    var body: some View {
        TabView {
            FastView()
                .tabItem { TabItemView(.fast) }
            HistoryView()
                .tabItem { TabItemView(.history) }
        }
        .frame(minWidth: 220, minHeight: 550)
    }
}

private struct TabItemView: View {
    
    private let tab: Tab
    
    init(_ tab: Tab) {
        self.tab = tab
    }
    
    var body: some View {
        Image(systemName: tab.iconName)
        Text(tab.title)
    }
    
}

private enum Tab {
    
    case fast, history
    
    var iconName: String {
        switch self {
        case .fast:
            return SystemImage.moon
        case .history:
            return SystemImage.calendar
        }
    }
    
    var title: String {
        switch self {
        case .fast:
            return Strings.today.localized
        case .history:
            return Strings.history.localized
        }
    }
    
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
