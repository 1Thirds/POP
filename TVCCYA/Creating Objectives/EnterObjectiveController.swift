//
//  EnterObjectiveController.swift
//  TVCCYA
//
//  Created by James Frys on 3/31/18.
//  Copyright © 2018 James Frys. All rights reserved.
//

import UIKit
import CoreData

class EnterObjectiveController: UIViewController, UITextFieldDelegate {
    
//    var objective: Objective? {
//        didSet {
//            objectiveTextField.text = objective?.task
//        }
//    }
    
    let objectiveTextField: UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Objective", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20), NSAttributedStringKey.foregroundColor: UIColor.mainLightGray])
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        tf.returnKeyType = .next
        return tf
    }()
    
    @objc func handleTextInputChange() {
        let isFormValid = objectiveTextField.text?.count ?? 0 > 0
        
        if isFormValid {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(handleNext))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: self, action: nil)
        }
    }
    
    @objc func handleNext() {
        toSelectIconController()
    }
    
    private func toSelectIconController() {
        let selectIconCollectionViewController = SelectIconCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        selectIconCollectionViewController.task = objectiveTextField.text!
        navigationController?.pushViewController(selectIconCollectionViewController, animated: true)
    }
    
    let line: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.mainLightGray
        return view
    }()
    
    let exampleLabel: UILabel = {
        let label = UILabel()
        label.text = "(ex) Workout/Cook/Read/Work"
        label.textColor = .mainLightGray
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationItem.title = objective == nil ? "Set Objective" : "Edit Objective"
        navigationItem.title = "Set Objective"
        view.backgroundColor = UIColor.mainLightBlue
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.extraLightBlue
        
        view.addSubview(backgroundView)
        backgroundView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 200)

        backgroundView.addSubview(objectiveTextField)
        objectiveTextField.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor).isActive = true
        objectiveTextField.anchor(top: nil, left: backgroundView.leftAnchor, bottom: nil, right: backgroundView.rightAnchor, paddingTop: 0, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: 0, height: 50)
        
        objectiveTextField.addSubview(line)
        line.anchor(top: nil, left: objectiveTextField.leftAnchor, bottom: objectiveTextField.bottomAnchor, right: objectiveTextField.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 8, paddingRight: 0, width: 0, height: 1)
        
        backgroundView.addSubview(exampleLabel)
        exampleLabel.anchor(top: line.bottomAnchor, left: line.leftAnchor, bottom: nil, right: line.rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        objectiveTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == objectiveTextField {
            self.view.endEditing(true)
            self.handleNext()
        }
        return true
    }
}
