//
//  CoreDataRepository.swift
//  Fasto
//
//  Created by Andrii Ponomarov on 06.02.2023.
//

import Foundation
import CoreData

final class CoreDataRepository<T: NSManagedObject> {
    
    typealias Entity = T
    
    private let managedObjectContext: NSManagedObjectContext

    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }
    
    func get(predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor] = []) -> [Entity] {
        let fetchRequest = Entity.fetchRequest()
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        let fetchResults = try? managedObjectContext.fetch(fetchRequest) as? [Entity]
        return fetchResults ?? []
    }
    
    func create() -> Entity {
        Entity(context: managedObjectContext)
    }
    
    func delete(entity: Entity) {
        managedObjectContext.delete(entity)
    }
    
    func save() {
        try? managedObjectContext.save()
    }
    
}
