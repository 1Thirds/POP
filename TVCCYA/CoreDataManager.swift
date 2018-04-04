//
//  CoreDataManager.swift
//  TVCCYA
//
//  Created by James Frys on 3/21/18.
//  Copyright © 2018 James Frys. All rights reserved.
//

import CoreData

struct CoreDataManager {
    
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "POPModel")
        container.loadPersistentStores { (storeDescription, err) in
            if let err = err {
                fatalError("Loading of store failed: \(err)")
            }
        }
        return container
    }()
    
    func fetchObjectives() -> [Objective] {
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Objective>(entityName: "Objective")
        
        let sort = NSSortDescriptor(key: "priority", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        
        do {
            let objectives = try context.fetch(fetchRequest)
            
            return objectives
            
        } catch let fetchErr {
            print("Failed to fetch objectives:", fetchErr)
            return []
        }
    }
}
