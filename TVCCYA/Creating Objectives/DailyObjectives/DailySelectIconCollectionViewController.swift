//
//  DailySelectIconCollectionViewController.swift
//  TVCCYA
//
//  Created by James Frys on 4/3/18.
//  Copyright © 2018 James Frys. All rights reserved.
//
//
//import UIKit
//import CoreData
//
//class DailySelectIconCollectionViewController: SelectIconCollectionViewController {
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        print(task)
//    }
//    
//    @objc override func handleSelect() {
//        if objective == nil {
//            createObjective()
//        } else {
//            saveObjectiveChanges()
//        }
//    }
//    
//    private func toObjectivesController() {
//        let objectivesController = ObjectivesController()
//        navigationController?.pushViewController(objectivesController, animated: true)
//    }
//    
//    private func saveObjectiveChanges() {
//        let context = CoreDataManager.shared.persistentContainer.viewContext
//        
//        objective?.task = task
//        objective?.icon = icon?.name
//        objective?.type = "daily"
//        
//        do {
//            try context.save()
//            self.delegate?.didEditObjective(objective: self.objective!)
//            toObjectivesController()
//        } catch let saveErr {
//            print("Failed to save objective changes:", saveErr)
//        }
//    }
//    
//    private func createObjective() {
//        let context = CoreDataManager.shared.persistentContainer.viewContext
//        
//        let objective = NSEntityDescription.insertNewObject(forEntityName: "Objective", into: context)
//        
//        objective.setValue(task, forKey: "task")
//        objective.setValue(icon?.name, forKey: "icon")
//        objective.setValue("Daily", forKey: "type")
//        
//        // perform the save
//        
//        do {
//            try context.save()
//            self.delegate?.didAddObjective(objective: objective as! Objective)
//            toObjectivesController()
//        } catch let saveErr {
//            print("Failed to save objective:", saveErr)
//        }
//    }
//}
