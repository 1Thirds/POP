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
            capNumber.text = objective?.amount
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationItem.title = objective?.task
    }
    
    let capAmountLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.mainDarkGray
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Cap Amount"
        return label
    }()
    
    let capNumber: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.mainDarkGreen
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let currentAmountLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.mainDarkGray
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Current Amount"
        return label
    }()
    
    let currentNumber: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.mainDarkGreen
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let updateAmountLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.mainDarkGray
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Update Amount"
        return label
    }()
    
    let updateAmountTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "###"
        tf.keyboardType = .numberPad
        return tf
    }()
    
    let updateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Update", for: .normal)
        button.backgroundColor = UIColor.mainLightBlue
        button.addTarget(self, action: #selector(handleSub), for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        return button
    }()
    
    @objc func handleSub() {
        print("see ya later fuckin mike")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.extraLightBlue
        
        view.addSubview(updateAmountLabel)
        updateAmountLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 50, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 150, height: 50)
        
        view.addSubview(updateAmountTextField)
        updateAmountTextField.anchor(top: updateAmountLabel.topAnchor, left: updateAmountLabel.rightAnchor, bottom: updateAmountLabel.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(updateButton)
        updateButton.anchor(top: updateAmountLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 24, paddingLeft: 50, paddingBottom: 50, paddingRight: 50, width: 0, height: 40)
        
        view.addSubview(capAmountLabel)
        capAmountLabel.anchor(top: updateButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 150, height: 50)
        
        view.addSubview(capNumber)
        capNumber.anchor(top: capAmountLabel.topAnchor, left: capAmountLabel.rightAnchor, bottom: capAmountLabel.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(currentAmountLabel)
        currentAmountLabel.anchor(top: capAmountLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 150, height: 50)
        
        view.addSubview(currentNumber)
        currentNumber.anchor(top: currentAmountLabel.topAnchor, left: currentAmountLabel.rightAnchor, bottom: currentAmountLabel.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
