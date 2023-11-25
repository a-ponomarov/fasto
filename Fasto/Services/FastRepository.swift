//
//  CoreDataRepository.swift
//  Fasto
//
//  Created by Andrii Ponomarov on 06.02.2023.
//

import Foundation
import CoreData

struct FastRepository {
    
    static let shared = FastRepository()
    
    private let persistenceController = PersistenceContainer()
    
    func get(predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor] = []) -> [Fast] {
        let fetchRequest = Fast.fetchRequest()
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        let fetchResults = try? persistenceController.viewContext.fetch(fetchRequest)
        return fetchResults ?? []
    }
    
    func create() -> Fast {
        Fast(context: persistenceController.viewContext)
    }
    
    func delete(entity: Fast) {
        persistenceController.viewContext.delete(entity)
    }
    
    func save() {
        try? persistenceController.viewContext.save()
    }
    
}
