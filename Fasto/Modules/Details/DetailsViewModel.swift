//
//  DetailsViewModel.swift
//  Fasto
//
//  Created by Andrii Ponomarov on 13.02.2023.
//

import Foundation

@MainActor
class DetailsViewModel: ObservableObject, Identifiable {
    
    private let fast: Fast
    private let repository: CoreDataRepository<Fast>
    private let completion: (() -> ())?
    
    @Published var startDate: Date
    @Published var endDate: Date
    
    init(fast: Fast, repository: CoreDataRepository<Fast>, completion: (() -> ())?) {
        self.fast = fast
        self.repository = repository
        self.startDate = fast.startDate ?? Date()
        self.endDate = fast.endDate ?? Date()
        self.completion = completion
    }
    
    func delete() {
        repository.delete(entity: fast)
    }

    func save() {
        fast.startDate = startDate
        fast.endDate = endDate
        repository.save()
        completion?()
    }
    
}
