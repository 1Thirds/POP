//
//  ObjectivesController+UITableView.swift
//  TVCCYA
//
//  Created by James Frys on 3/27/18.
//  Copyright © 2018 James Frys. All rights reserved.
//

import UIKit

extension ObjectivesController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let objective = objectives[indexPath.row]
        let progressionController = ProgressionController()
        progressionController.objective = objective
        navigationController?.pushViewController(progressionController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (_, indexPath) in
            let objective = self.objectives[indexPath.row]
            print("attempting to delete objective:", objective.task ?? "")
            
            // remove the task from our tableView
            
            self.objectives.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            // delete the objective from core data
            let context = CoreDataManager.shared.persistentContainer.viewContext
            
            context.delete(objective)
            
            do {
                try context.save()
            } catch let saveErr {
                print("Failed to delete objective:", saveErr)
            }
        }
        
        deleteAction.backgroundColor = UIColor.deleteRed
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler: editHandlerFunction)
        
        editAction.backgroundColor = UIColor.mainBlue
        
        return [deleteAction, editAction]
    }
    
    private func editHandlerFunction(action: UITableViewRowAction, indexPath: IndexPath) {
        print("Editing objective in separate function")
        
        let enterObjectiveController = CreateObjectiveController()
        
        enterObjectiveController.delegate = self
        
        enterObjectiveController.objective = objectives[indexPath.row]
        
        //        let navController = CustomNavigationController(rootViewController: editObjectiveController)
        
        navigationController?.pushViewController(enterObjectiveController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Plan an Objective"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return objectives.count == 0 ? 150 : 0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.extraLightBlue
        
        let label = UILabel()
        label.text = "Weekly"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = UIColor.mainLightBlue
        
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "plus"), for: .normal)
        
        view.addSubview(label)
        label.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 24, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ObjectiveCell
        
        let objective = objectives[indexPath.row]
        cell.objective = objective
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectives.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
        return 50
    }
}
