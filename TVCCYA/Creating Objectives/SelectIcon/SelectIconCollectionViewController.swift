//
//  SelectIconCollectionViewController.swift
//  TVCCYA
//
//  Created by James Frys on 3/23/18.
//  Copyright © 2018 James Frys. All rights reserved.
//

import UIKit
import CoreData

class SelectIconCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var delegate: CreateObjectiveControllerDelegate?
    
    var objective: Objective? {
        didSet {
            guard let objectiveTask = objective?.task else { return }
            task = objectiveTask
            
            icon?.name = objective?.icon
        }
    }
    
    var task = ""
    var type = ""
    
    var icons = [SelectIconCell]()
    
    var cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.mainLightBlue
        
        collectionView?.alwaysBounceVertical = true
        
        navigationItem.title = "Select Icon"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Select", style: .plain, target: self, action: #selector(handleSelect))
        
        collectionView?.register(SelectIconCells.self, forCellWithReuseIdentifier: cellId)
        
        setupCells()
    }
    
    @objc func handleSelect() {
        if type == "Daily" {
            if objective == nil {
                createObjective()
            } else {
                saveObjectiveChanges()
            }
        } else {
            toAmountController()
        }
    }
    
    private func toAmountController() {
        let amountController = AmountController()
        
        amountController.task = task
        
        if let iconName = icon?.name {
            amountController.iconName = iconName
        }
        
        amountController.type = type
        
        navigationController?.pushViewController(amountController, animated: true)
    }
    
    private func toObjectivesController() {
        let objectivesController = ObjectivesController()
        navigationController?.pushViewController(objectivesController, animated: true)
    }
    
    private func saveObjectiveChanges() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        objective?.task = task
        objective?.icon = icon?.name
        
        do {
            try context.save()
            self.delegate?.didEditObjective(objective: self.objective!)
            toObjectivesController()
        } catch let saveErr {
            print("Failed to save objective changes:", saveErr)
        }
    }
    
    private func createObjective() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let objective = NSEntityDescription.insertNewObject(forEntityName: "Objective", into: context)
        
        objective.setValue(task, forKey: "task")
        objective.setValue(icon?.name, forKey: "icon")
        objective.setValue(type, forKey: "type")
        
        // perform the save
        
        do {
            try context.save()
            self.delegate?.didAddObjective(objective: objective as! Objective)
            toObjectivesController()
        } catch let saveErr {
            print("Failed to save objective:", saveErr)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return icons.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SelectIconCells
        
        cell.selectIconCell = icons[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 50, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
    
    // width between cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return ((view.frame.width / 3) / 3) - 6
    }
    
    // padding between cells and physical phone screen bounds
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 24, left: 12, bottom: 8, right: 12)
    }
    
    var icon: SelectIconCell?
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        icon = icons[indexPath.row]
    }
}
