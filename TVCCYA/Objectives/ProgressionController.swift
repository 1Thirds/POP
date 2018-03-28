//
//  ProgressionController.swift
//  TVCCYA
//
//  Created by James Frys on 3/27/18.
//  Copyright © 2018 James Frys. All rights reserved.
//

import UIKit

class ProgressionController: UIViewController {
    
    var objective: Objective?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationItem.title = objective?.task
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.extraLightBlue
        
        navigationItem.title = "Progression"
    }
}
