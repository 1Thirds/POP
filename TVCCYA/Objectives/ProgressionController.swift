//
//  ProgressionController.swift
//  TVCCYA
//
//  Created by James Frys on 3/27/18.
//  Copyright © 2018 James Frys. All rights reserved.
//

import UIKit

class ProgressionController: UIViewController {
    
    var objective: Objective? {
        didSet {
            unitLabel.text = objective?.unit
            amountLabel.text = objective?.amount
            purposeLabel.text = objective?.purpose
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationItem.title = objective?.task
    }
    
    let unitLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.mainLightGreen
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let amountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.mainDarkGreen
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let purposeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.mainDarkGray
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.extraLightBlue
        
        navigationItem.title = "Progression"
        
        view.addSubview(unitLabel)
        unitLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 50, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(amountLabel)
        amountLabel.anchor(top: unitLabel.topAnchor, left: view.leftAnchor, bottom: unitLabel.bottomAnchor, right: unitLabel.leftAnchor, paddingTop: 0, paddingLeft: 50, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    
        view.addSubview(purposeLabel)
        purposeLabel.anchor(top: amountLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 50, paddingLeft: 25, paddingBottom: 0, paddingRight: 25, width: 0, height: 0)
    }
}
