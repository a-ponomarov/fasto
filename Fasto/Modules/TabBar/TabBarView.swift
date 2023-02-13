//
//  TabBarView.swift
//  Fasto
//
//  Created by Andrii Ponomarov on 06.02.2023.
//

import SwiftUI

struct TabBarView: View {

    let repository: CoreDataRepository<Fast>
    
    var body: some View {
        TabView {
            FastView()
                .environmentObject(FastViewModel(repository: repository))
                .tabItem {
                    Image(systemName: SystemImage.moon)
                    Text(Strings.today.localized)
                }
            HistoryView()
                .environmentObject(HistoryViewModel(repository: repository))
                .tabItem {
                    Image(systemName: SystemImage.calendar)
                    Text(Strings.history.localized)
                }
        }
        
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(repository: CoreDataRepository<Fast>(managedObjectContext: PersistenceController().viewContext))
    }
}
