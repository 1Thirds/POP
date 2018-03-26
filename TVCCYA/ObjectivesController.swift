//
//  TableView.swift
//  TVCCYA
//
//  Created by James Frys on 3/18/18.
//  Copyright © 2018 James Frys. All rights reserved.
//

import UIKit
import CoreData

class ObjectivesController: UITableViewController, CreateObjectiveControllerDelegate {
    
    func didEditObjective(objective: Objective) {
        let row = objectives.index(of: objective)
        
        let reloadIndexPath = IndexPath(row: row!, section: 0)
        
        tableView.reloadRows(at: [reloadIndexPath], with: .middle)
    }
    
    func didAddObjective(objective: Objective) {
        objectives.append(objective)
        
        let newIndexPath = IndexPath(row: objectives.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    
    var objectives = [Objective]()
    
    let cellId = "cellId"
    
    let addObjButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleObjective), for: .touchUpInside)
        return button
    }()
    
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
        
        let editObjectiveController = CreateObjectiveController()
        
        editObjectiveController.delegate = self
        
        editObjectiveController.objective = objectives[indexPath.row]
        
//        let navController = CustomNavigationController(rootViewController: editObjectiveController)
        
        navigationController?.pushViewController(editObjectiveController, animated: true)
    }
    
    private func fetchObjectives() {
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Objective>(entityName: "Objective")
        
        do {
            let objectives = try context.fetch(fetchRequest)
            
            objectives.forEach({ (objective) in
                print(objective.task ?? "")
            })
            
            self.objectives = objectives
            self.tableView.reloadData()
            
        } catch let fetchErr {
            print("Failed to fetch objectives:", fetchErr)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchObjectives()
        
        view.backgroundColor = .white
        
        navigationItem.title = "Objectives"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleObjective))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sub cunt", style: .plain
            , target: self, action: #selector(handleSubscribe))
        
        tableView.backgroundColor = UIColor.mainLightBlue
        tableView.tableFooterView = UIView()
        tableView.separatorColor = .white
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
//        view.addSubview(addObjButton)
//        addObjButton.anchor(top: nil, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: nil, paddingTop: 74, paddingLeft: 0, paddingBottom: 12, paddingRight: 0, width: 50, height: 50)
//        addObjButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    @objc func handleSubscribe() {
        let subscribeController = SubcscribeController()
        navigationController?.pushViewController(subscribeController, animated: true)
    }
    
    @objc func handleObjective() {
        let createObjectiveController = CreateObjectiveController()
        
//        let navController = CustomNavigationController(rootViewController: createObjectiveController)
        
        createObjectiveController.delegate = self
        
//        present(navController, animated: true, completion: nil)
        
        navigationController?.pushViewController(createObjectiveController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.extraLightBlue
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        let objective = objectives[indexPath.row]
        
        cell.backgroundColor = UIColor.cellBlue
 
        cell.textLabel?.text = objective.task
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectives.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
        return UITableViewAutomaticDimension
    }
}
