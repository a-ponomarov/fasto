//
//  FastoApp.swift
//  Fasto
//
//  Created by Andrii Ponomarov on 11.10.2022.
//

import SwiftUI

@main
struct FastoApp: App {
    
    private let persistenceController = PersistenceController()

    var body: some Scene {
        WindowGroup {
            TabBarView(repository: CoreDataRepository<Fast>(managedObjectContext: persistenceController.viewContext))
        }
    }
}
