//
//  TableView.swift
//  TVCCYA
//
//  Created by James Frys on 3/18/18.
//  Copyright © 2018 James Frys. All rights reserved.
//

import UIKit
import CoreData

class ObjectivesController: UITableViewController {
    
    var objectives = [Objective]()
    
    var allObjectives = [[Objective]]()
    
    let cellId = "cellId"
    
    let addObjButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal).alpha(0.75), for: .normal)
        button.addTarget(self, action: #selector(handleObjective), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.backgroundView = refreshControl
        }
        
        self.objectives = CoreDataManager.shared.fetchObjectives()
        
        view.backgroundColor = .white
        
        navigationItem.title = "POP"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleObjective))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Subscribe", style: .plain
            , target: self, action: #selector(handleSubscribe))
        
        tableView.backgroundColor = UIColor.mainLightBlue
        tableView.tableFooterView = UIView()
        tableView.separatorColor = .white
        
        tableView.register(ObjectiveCell.self, forCellReuseIdentifier: cellId)
        
        fetchObjectives()
        
//        view.addSubview(addObjButton)
//        addObjButton.anchor(top: nil, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 12, paddingRight: 12, width: 75, height: 75)
//        addObjButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    @objc func refresh(_ refreshControl: UIRefreshControl) {
        //let objectives = [Objective]()
        self.objectives = CoreDataManager.shared.fetchObjectives()
        print(objectives)
        var indexPathsToReload = [IndexPath]()
        
        for (index, _) in objectives.enumerated() {
            let indexPath = IndexPath(row: index, section: 0)
            indexPathsToReload.append(indexPath)
        }
        
        self.tableView.reloadRows(at: indexPathsToReload, with: .right)
        self.tableView.reloadData()
        fetchObjectives()
        refreshControl.endRefreshing()
    }
    
    @objc func handleSubscribe() {
        let subscribeController = SubcscribeController()
        navigationController?.pushViewController(subscribeController, animated: true)
    }
    
    @objc func handleObjective() {
        let enterObjectiveController = EnterObjectiveController()
        navigationController?.pushViewController(enterObjectiveController, animated: true)
    }
}
