//
//  UnitController.swift
//  TVCCYA
//
//  Created by James Frys on 3/31/18.
//  Copyright © 2018 James Frys. All rights reserved.
//

import UIKit

class AmountController: UIViewController, UITextFieldDelegate {
    
//    var objective: Objective? {
//        didSet {
//            if let icon = objective?.icon {
//                iconName = icon
//            }
//            if let objectiveTask = objective?.task {
//                task = objectiveTask
//            }
//            unitTextField.text = objective?.unit
//            amountTextField.text = objective?.amount
//        }
//    }
    
    var task = ""
    var iconName = ""
    var type = ""
    
    let amountTextField: UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "#", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20), NSAttributedStringKey.foregroundColor: UIColor.mainLightGray])
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        tf.keyboardType = .numberPad
        return tf
    }()
    
    let amountLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.mainLightGray
        return view
    }()
    
    let ofLabel: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.textColor = UIColor.mainDarkGray
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let unitTextField: UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Unit", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20), NSAttributedStringKey.foregroundColor: UIColor.mainLightGray])
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        tf.returnKeyType = .next
        return tf
    }()
    
    @objc func handleTextInputChange() {
        let isFormValid = unitTextField.text?.count ?? 0 > 0 && amountTextField.text?.count ?? 0 > 0
        
        if isFormValid {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(handleNext))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: self, action: nil)
        }
    }
    
    @objc func handleNext() {
        toPurposeController()
    }
    
    private func toPurposeController() {
        let purposeController = PurposeController()
        purposeController.task = task
        purposeController.iconName = iconName
        purposeController.unit = unitTextField.text!
        purposeController.amount = amountTextField.text!
        purposeController.type = type
        
        navigationController?.pushViewController(purposeController, animated: true)
    }
    
    let line: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.mainLightGray
        return view
    }()
    
    let exampleLabel: UILabel = {
        let label = UILabel()
        label.text = "(ex) Hours/Books/Times"
        label.textColor = .mainLightGray
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.mainLightBlue
        
        navigationItem.title = "Set Amount"
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.extraLightBlue
        
        view.addSubview(backgroundView)
        backgroundView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 200)
        
        backgroundView.addSubview(amountTextField)
        amountTextField.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor).isActive = true
        amountTextField.anchor(top: nil, left: backgroundView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 32, paddingBottom: 0, paddingRight: 0, width: 60, height: 0)
        
        amountTextField.addSubview(amountLine)
        amountLine.anchor(top: nil, left: amountTextField.leftAnchor, bottom: amountTextField.bottomAnchor, right: amountTextField.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 8, paddingRight: 0, width: 0, height: 1)
        
        backgroundView.addSubview(ofLabel)
        ofLabel.anchor(top: amountTextField.topAnchor, left: amountTextField.rightAnchor, bottom: amountTextField.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 20, height: 0)
        
        backgroundView.addSubview(unitTextField)
//        unitTextField.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor).isActive = true
        unitTextField.anchor(top: ofLabel.topAnchor, left: ofLabel.rightAnchor, bottom: ofLabel.bottomAnchor, right: backgroundView.rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 30, width: 0, height: 50)
        
        unitTextField.addSubview(line)
        line.anchor(top: nil, left: unitTextField.leftAnchor, bottom: unitTextField.bottomAnchor, right: unitTextField.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 8, paddingRight: 0, width: 0, height: 1)

        backgroundView.addSubview(exampleLabel)
        exampleLabel.anchor(top: line.bottomAnchor, left: line.leftAnchor, bottom: nil, right: line.rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        amountTextField.delegate = self
        unitTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == unitTextField {
            self.view.endEditing(true)
            self.handleNext()
        }
        return true
    }
}
