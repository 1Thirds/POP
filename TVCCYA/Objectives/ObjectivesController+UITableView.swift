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
        let objective = allObjectives[indexPath.section][indexPath.row]
        let progressionController = ProgressionController()
        progressionController.objective = objective
        navigationController?.pushViewController(progressionController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Done") { (_, indexPath) in
            let objective = self.allObjectives[indexPath.section][indexPath.row]
            
            // remove the task from our tableView
            self.allObjectives[indexPath.section].remove(at: indexPath.row)
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
        
        deleteAction.backgroundColor = UIColor.doneGreen
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler: editHandlerFunction)
        
        editAction.backgroundColor = UIColor.mainBlue
        
        return [deleteAction, editAction]
    }
    
    private func editHandlerFunction(action: UITableViewRowAction, indexPath: IndexPath) {
        
        let enterObjectiveController = CreateObjectiveController()
        
        enterObjectiveController.delegate = self
        
        enterObjectiveController.objective = allObjectives[indexPath.section][indexPath.row]
        
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
        if section == 0 {
            return objectives.count == 0 ? 75 : 0
        }
        return 0
    }
    
    func fetchObjectives() {
        let daily = objectives.filter { $0.type == "Daily" }
        let weekly = objectives.filter { $0.type == "Weekly" }
        let monthly = objectives.filter { $0.type == "Monthly" }
        let yearly = objectives.filter { $0.type == "Yearly" }
        
        allObjectives = [
            daily,
            weekly,
            monthly,
            yearly
        ]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return allObjectives.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.extraLightBlue
        
        let button = UIButton()
        
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.mainLightBlue
        
        if section == 0 {
            label.text = "Daily"
//            button.setImage(#imageLiteral(resourceName: "dailyPlus").withRenderingMode(.alwaysOriginal), for: .normal)
//            button.addTarget(self, action: #selector(handleDailyObjective), for: .touchUpInside)
        } else if section == 1 {
            label.text = "Weekly"
//            button.setImage(#imageLiteral(resourceName: "weeklyPlus").withRenderingMode(.alwaysOriginal), for: .normal)
//            button.addTarget(self, action: #selector(handleObjective), for: .touchUpInside)
        } else if section == 2 {
            label.text = "Monthly"
//            button.setImage(#imageLiteral(resourceName: "monthlyPlus").withRenderingMode(.alwaysOriginal), for: .normal)
//            button.addTarget(self, action: #selector(handleObjective), for: .touchUpInside)
        } else {
            label.text = "Yearly"
//            button.setImage(#imageLiteral(resourceName: "yearlyPlus").withRenderingMode(.alwaysOriginal), for: .normal)
//            button.addTarget(self, action: #selector(handleObjective), for: .touchUpInside)
        }
        
        view.addSubview(label)
        label.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(button)
        button.anchor(top: nil, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 40, height: 40)
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ObjectiveCell
        
        let objective = allObjectives[indexPath.section][indexPath.row]

//        let objective = objectives[indexPath.row]
        cell.objective = objective
        
        let backgroundView = UIView()
        
        if indexPath.section == 0 {
            backgroundView.backgroundColor = UIColor.mainBlue
            cell.addSubview(cell.slider)
            cell.slider.anchor(top: nil, left: cell.objectiveLabel.rightAnchor, bottom: nil, right: cell.rightAnchor, paddingTop: 0, paddingLeft: 4, paddingBottom: 0, paddingRight: 4, width: 0, height: 0)
            cell.slider.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
        } else if indexPath.section == 1 {
            backgroundView.backgroundColor = UIColor.mainLightGreen
        } else if indexPath.section == 2 {
            backgroundView.backgroundColor = UIColor.mainLightOrange
        } else {
            backgroundView.backgroundColor = UIColor.mainRed
        }
        
        cell.selectedBackgroundView = backgroundView
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allObjectives[section].count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
