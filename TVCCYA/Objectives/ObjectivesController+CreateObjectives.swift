//
//  ObjectivesController+CreateObjectives.swift
//  TVCCYA
//
//  Created by James Frys on 3/27/18.
//  Copyright © 2018 James Frys. All rights reserved.
//

import UIKit

extension ObjectivesController: CreateObjectiveControllerDelegate {
    
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
}
