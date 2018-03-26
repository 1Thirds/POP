//
//  ViewController.swift
//  TVCCYA
//
//  Created by James Frys on 3/18/18.
//  Copyright © 2018 James Frys. All rights reserved.
//

import UIKit
import CoreData

protocol CreateObjectiveControllerDelegate {
    func didAddObjective(objective: Objective)
    func didEditObjective(objective: Objective)
}

class CreateObjectiveController: UIViewController, UITextFieldDelegate {
    
    var objective: Objective? {
        didSet {
            objTextField.text = objective?.task
        }
    }
    
    var delegate: CreateObjectiveControllerDelegate?
    
    lazy var iconImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "select").withRenderingMode(.alwaysOriginal))
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectIcon)))
        return iv
    }()
    
    @objc private func handleSelectIcon() {
        let selectIconCollectionViewController = SelectIconCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        
        let navController = CustomNavigationController(rootViewController: selectIconCollectionViewController)
        
        present(navController, animated: true, completion: nil)
    }
    
    let objLabel: UILabel = {
        let label = UILabel()
        label.text = "Objective"
        label.textColor = UIColor.mainDarkGray
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let objTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "(ex) run/paint/read"
        return tf
    }()
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == objTextField {
            self.view.endEditing(true)
            handleSave()
        }
        return true
    }
    
    let unitLabel: UILabel = {
        let label = UILabel()
        label.text = "Unit"
        label.textColor = UIColor.mainDarkGray
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let unitTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "(ex) hours/times/books"
        return tf
    }()
    
    let purposeLabel: UILabel = {
        let label = UILabel()
        label.text = "Purpose"
        label.textColor = UIColor.mainDarkGray
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let purposeTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Why should you do this?"
        return tf
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationItem.title = objective == nil ? "POP" : "Edit POP"
        
//        print("Image ICON:", objective?.icon ?? "")
    }
    
    var setTaskBottomAnchor: NSLayoutConstraint?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .mainLightBlue
    
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
        
        objTextField.delegate = self

        setupUI()
    }
    
    @objc func handleSave() {
        if objective == nil {
            createObjective()
        } else {
            saveObjectiveChanges()
        }
    }
    
    private func saveObjectiveChanges() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        objective?.task = objTextField.text
        
        do {
            try context.save()
            self.delegate?.didEditObjective(objective: self.objective!)
            navigationController?.popViewController(animated: true)
            
            // save succeeded
//            dismiss(animated: true, completion: {
//                
//            })
            
        } catch let saveErr {
            print("Failed to save objective changes:", saveErr)
        }
    }
    
    private func createObjective() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let objective = NSEntityDescription.insertNewObject(forEntityName: "Objective", into: context)
        
        objective.setValue(objTextField.text, forKey: "task")
        
        // perform the save
        
        do {
            try context.save()
            self.delegate?.didAddObjective(objective: objective as! Objective)
            navigationController?.popToRootViewController(animated: true)
            // success
//            dismiss(animated: true, completion: {
//
//            })
            
        } catch let saveErr {
            print("Failed to save objective:", saveErr)
        }
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func setupUI() {
        
        let lightBlueBackgroundView = UIView()
        lightBlueBackgroundView.backgroundColor = UIColor.extraLightBlue
        
        view.addSubview(lightBlueBackgroundView)
        lightBlueBackgroundView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 245)
        
        view.addSubview(iconImageView)
        iconImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 75, height: 75)
        iconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        iconImageView.layer.cornerRadius = 100 / 2
        
        view.addSubview(objLabel)
        objLabel.anchor(top: iconImageView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 100, height: 50)
        
        view.addSubview(objTextField)
        objTextField.anchor(top: objLabel.topAnchor, left: objLabel.rightAnchor, bottom: objLabel.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(unitLabel)
        unitLabel.anchor(top: objLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 100, height: 50)
        
        view.addSubview(unitTextField)
        unitTextField.anchor(top: unitLabel.topAnchor, left: unitLabel.rightAnchor, bottom: unitLabel.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(purposeLabel)
        purposeLabel.anchor(top: unitLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 100, height: 50)
        
        view.addSubview(purposeTextField)
        purposeTextField.anchor(top: purposeLabel.topAnchor, left: purposeLabel.rightAnchor, bottom: purposeLabel.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    func setupKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
    }
    
    @objc func handleKeyboardNotification(notification: NSNotification) {
        
        if let userInfo = notification.userInfo {
            guard let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
            let isKeyboardShowing = notification.name == NSNotification.Name.UIKeyboardWillShow
            
            setTaskBottomAnchor?.constant = isKeyboardShowing ? -keyboardFrame.height : 0
            
            UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: { (completed) in
                if isKeyboardShowing {
                }
            })
        }
        
    }
}

