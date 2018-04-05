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
        if indexPath.section == 0 {

        } else {
            let objective = allObjectives[indexPath.section].objectives[indexPath.row]
            let progressionController = ProgressionController()
            progressionController.objective = objective
            navigationController?.pushViewController(progressionController, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Done") { (_, indexPath) in
            let objective = self.allObjectives[indexPath.section].objectives[indexPath.row]
            
            // remove the task from our tableView
            self.allObjectives[indexPath.section].objectives.remove(at: indexPath.row)
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
        
        enterObjectiveController.objective = allObjectives[indexPath.section].objectives[indexPath.row]
        
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
            ExpandableObjectives(isExpanded: true, objectives: daily),
            ExpandableObjectives(isExpanded: true, objectives: weekly),
            ExpandableObjectives(isExpanded: true, objectives: monthly),
            ExpandableObjectives(isExpanded: true, objectives: yearly)
//            daily,
//            weekly,
//            monthly,
//            yearly
        ]
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return allObjectives.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.extraLightBlue
        
        let button = UIButton()
        button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        button.tag = section
        
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.mainLightBlue
        
        let rowCountLabel = UILabel()
        rowCountLabel.textAlignment = .center
        
        let attributedText = NSMutableAttributedString(string: "[", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 20), NSAttributedStringKey.foregroundColor: UIColor.mainLightGray])
        
        attributedText.append(NSAttributedString(string: "\(allObjectives[section].objectives.count)", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedStringKey.foregroundColor: UIColor.mainBlue]))
        
        attributedText.append(NSAttributedString(string: "]", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 20), NSAttributedStringKey.foregroundColor: UIColor.mainLightGray]))
        
        rowCountLabel.attributedText = attributedText
        
        if section == 0 {
            label.text = "Daily"
        } else if section == 1 {
            label.text = "Weekly"
        } else if section == 2 {
            label.text = "Monthly"
        } else {
            label.text = "Yearly"
        }
        
        view.addSubview(button)
        button.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        button.addSubview(label)
        label.anchor(top: button.topAnchor, left: button.leftAnchor, bottom: button.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        button.addSubview(rowCountLabel)
        rowCountLabel.anchor(top: label.topAnchor, left: nil, bottom: label.bottomAnchor, right: button.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        let objective = allObjectives[indexPath.section].objectives[indexPath.row]

//        let objective = objectives[indexPath.row]
//        cell.objective = objective
        
        let backgroundView = UIView()
        
        if indexPath.section == 0 {
            let dailyCell = tableView.dequeueReusableCell(withIdentifier: dailyCellId, for: indexPath) as! DailyCell
            dailyCell.objective = objective
            
            cell = dailyCell
        } else if indexPath.section == 1 {
            let weeklyCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ObjectiveCell
            weeklyCell.objective = objective
            backgroundView.backgroundColor = UIColor.mainLightGreen
            
            cell = weeklyCell
        } else if indexPath.section == 2 {
            let monthlyCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ObjectiveCell
            monthlyCell.objective = objective
            backgroundView.backgroundColor = UIColor.mainLightOrange
            
            cell = monthlyCell
        } else if indexPath.section == 3 {
            let yearlyCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ObjectiveCell
            yearlyCell.objective = objective
            backgroundView.backgroundColor = UIColor.mainLightOrange
            
            cell = yearlyCell
        }
        
        cell.selectedBackgroundView = backgroundView
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !allObjectives[section].isExpanded {
            return 0
        }
        return allObjectives[section].objectives.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
