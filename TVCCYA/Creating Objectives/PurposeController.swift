//
//  PurposeController.swift
//  TVCCYA
//
//  Created by James Frys on 3/31/18.
//  Copyright © 2018 James Frys. All rights reserved.
//

import UIKit
import CoreData

class PurposeController: UIViewController, UITextFieldDelegate {
    
    var objective: Objective? {
        didSet {
            guard let icon = objective?.icon else { return }
            guard let objectiveTask = objective?.task else { return }
            guard let unitText = objective?.unit else { return }
            guard let amountText = objective?.amount else { return }
            
            iconName = icon
            task = objectiveTask
            unit = unitText
            amount = amountText
            
            purposeTextField.text = objective?.purpose
        }
    }
    
    var task = ""
    var iconName = ""
    var unit = ""
    var amount = ""
    var delegate: CreateObjectiveControllerDelegate?
    
    let purposeTextField: UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Purpose", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20), NSAttributedStringKey.foregroundColor: UIColor.mainLightGray])
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        tf.returnKeyType = .done
        return tf
    }()
    
    @objc func handleTextInputChange() {
        let isFormValid = purposeTextField.text?.count ?? 0 > 0
        
        if isFormValid {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(handleDone))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: self, action: nil)
        }
    }
    
    @objc func handleDone() {
        if objective == nil {
            createObjective()
        } else {
            saveObjectiveChanges()
        }
    }
    
    private func toObjectivesController() {
        let objectivesController = ObjectivesController()
        navigationController?.pushViewController(objectivesController, animated: true)
//        navigationController?.popToRootViewController(animated: true)
    }
    
    private func saveObjectiveChanges() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        objective?.task = task
        objective?.icon = iconName
        objective?.unit = unit
        objective?.amount = amount
        objective?.purpose = purposeTextField.text
        
        do {
            try context.save()
            self.delegate?.didEditObjective(objective: self.objective!)
            toObjectivesController()
        } catch let saveErr {
            print("Failed to save objective changes:", saveErr)
        }
    }
    
    private func createObjective() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let objective = NSEntityDescription.insertNewObject(forEntityName: "Objective", into: context)
        
        objective.setValue(task, forKey: "task")
        objective.setValue(iconName, forKey: "icon")
        objective.setValue(unit, forKey: "unit")
        objective.setValue(amount, forKey: "amount")
        objective.setValue(purposeTextField.text, forKey: "purpose")
        
        // perform the save
        
        do {
            try context.save()
            self.delegate?.didAddObjective(objective: objective as! Objective)
            toObjectivesController()
        } catch let saveErr {
            print("Failed to save objective:", saveErr)
        }
    }
    
    let line: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.mainLightGray
        return view
    }()
    
    let exampleLabel: UILabel = {
        let label = UILabel()
        label.text = "Why should you do this?\nKeep it short and to the point!"
        label.numberOfLines = 0
        label.textColor = .mainLightGray
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.mainLightBlue
        
        navigationItem.title = "Set Purpose"
        view.backgroundColor = UIColor.mainLightBlue
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.extraLightBlue
        
        view.addSubview(backgroundView)
        backgroundView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 200)
        
        backgroundView.addSubview(purposeTextField)
        purposeTextField.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor).isActive = true
        purposeTextField.anchor(top: nil, left: backgroundView.leftAnchor, bottom: nil, right: backgroundView.rightAnchor, paddingTop: 0, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: 0, height: 50)
        
        purposeTextField.addSubview(line)
        line.anchor(top: nil, left: purposeTextField.leftAnchor, bottom: purposeTextField.bottomAnchor, right: purposeTextField.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 8, paddingRight: 0, width: 0, height: 1)
        
        backgroundView.addSubview(exampleLabel)
        exampleLabel.anchor(top: line.bottomAnchor, left: line.leftAnchor, bottom: nil, right: line.rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        purposeTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == purposeTextField {
            self.view.endEditing(true)
            self.handleDone()
        }
        return true
    }
}
