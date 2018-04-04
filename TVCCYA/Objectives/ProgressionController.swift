//
//  ProgressionController.swift
//  TVCCYA
//
//  Created by James Frys on 3/27/18.
//  Copyright © 2018 James Frys. All rights reserved.
//

import UIKit
import CoreData

class ProgressionController: UIViewController {
    
    var objective: Objective? {
        didSet {
            purposeLabel.text = objective?.purpose
            taskLabel.text = objective?.task
            capNumber.text = objective?.amount
            
            if let objectiveUnit = objective?.unit {
                unitLabel.text = "(\(objectiveUnit))"
            }
            
            setupAttributedCurrentProgress()
        }
    }
    
    fileprivate func setupAttributedCurrentProgress() {
        guard let objectiveType = objective?.type else { return }
        
        if objectiveType == "Weekly" {
            attributedTextHelper(color: UIColor.mainLightGreen)
            progressView.progressTintColor = UIColor.mainLightGreen
            capNumber.textColor = UIColor.mainDarkGreen
        } else if objectiveType == "Monthly" {
            attributedTextHelper(color: UIColor.mainLightOrange)
            progressView.progressTintColor = UIColor.mainLightOrange
            capNumber.textColor = UIColor.mainOrange
        } else if objectiveType == "Yearly" {
            attributedTextHelper(color: UIColor.mainRed)
            progressView.progressTintColor = UIColor.mainRed
            capNumber.textColor = UIColor.mainDarkRed
        }
    }
    
    private func attributedTextHelper(color: UIColor) {
        guard let updateAmount = objective?.updateAmount else { return }
        guard let objectiveAmount = objective?.amount else { return }
        guard let objectiveUnit = objective?.unit else { return }
        
        let attributedText = NSMutableAttributedString(string: updateAmount, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: color])
        
        attributedText.append(NSAttributedString(string: " / \(objectiveAmount) ", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.mainDarkGray]))
        
        attributedText.append(NSAttributedString(string: "\(objectiveUnit)", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.mainLightGray]))
        
        currentProgress.attributedText = attributedText
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationItem.title = objective?.type
    }
    
    let capNumber: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let purposeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.mainDarkGray
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let updateAmountLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.mainDarkGray
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Update Amount"
        return label
    }()
    
    let gratsLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.mainDarkGray
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.text = "Grats!"
        return label
    }()
    
    let line: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.mainLightGray
        return view
    }()
    
    let enterProgressTextField: UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Enter Progress", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20), NSAttributedStringKey.foregroundColor: UIColor.mainLightGray])
        tf.textAlignment = .center
        tf.keyboardType = .numberPad
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    @objc func handleTextInputChange() {
        let isFormValid = enterProgressTextField.text?.count ?? 0 > 0
        
        if isFormValid {
            updateButton.isEnabled = true
            updateButton.backgroundColor = UIColor.mainLightBlue
        } else {
            updateButton.isEnabled = false
            updateButton.backgroundColor = UIColor.mainLightBlue.withAlphaComponent(0.5)
        }
    }
    
    let updateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Update", for: .normal)
        button.addTarget(self, action: #selector(handleAmountAdded), for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.backgroundColor = UIColor.mainLightBlue.withAlphaComponent(0.5)
        button.layer.cornerRadius = 5
        return button
    }()
    
    func setProgress() {
        
        setupAttributedCurrentProgress()
        
        guard let capValue = objective?.amount else {return}
        guard let currentValue = objective?.updateAmount else {return}

        let capVal = Double(capValue)
        guard let capDouble = capVal else { return }
        let currentVal = Double(currentValue)

        guard let currentDouble = currentVal else { return }
        let currentPercent = ((currentDouble * 100)/capDouble) * 0.01

        //progressView.setProgress(Float(currentPercent), animated: true)
        progressView.animate(currentPercent: Float(currentPercent), duration: 1.5)
    }
    
//    func getCurrentProgress() -> String {
//        let currentProgress = String((objective?.updateAmount)! + "/" + (objective?.amount)!)
//        return currentProgress
//    }
    
    let currentProgress: UILabel = {
        let label = UILabel()
        label.textColor = .mainLightGray
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let progressView: UIProgressView = {
        let pv = UIProgressView()
        //progressView.setProgress(currentPercent, animated: true)
        pv.translatesAutoresizingMaskIntoConstraints = false
        pv.trackTintColor = UIColor.mainLightGray.withAlphaComponent(0.6)
        return pv
    }()
    
    @objc func handleAmountAdded() {
        let isFormValid = enterProgressTextField.text?.count ?? 0 > 0
        
        if isFormValid {
            self.view.endEditing(true)
            guard let currentValue = objective?.updateAmount else { return }
            let currentVal = Double(currentValue)
            guard let currentDouble = currentVal else { return }
            
            guard let inputValue = enterProgressTextField.text else { return }
            let inputVal = Double(inputValue)
            guard let inputDouble = inputVal else { return }
            
            guard let capValue = objective?.amount else { return }
            let capVal = Double(capValue)
            guard let capDouble = capVal else { return }
            
            let totalUpdateValInt = Int(currentDouble + inputDouble)
            var totalUpdateVal = String(totalUpdateValInt)
            let totalUpdateValDouble = currentDouble + inputDouble
            
            if (totalUpdateValDouble >= capDouble) {
                if let objectiveAmount = objective?.amount {
                    totalUpdateVal = objectiveAmount
                }
            }
            updateAmountInCoreData(totalUpdateVal: totalUpdateVal)
        }
    }
    
    private func updateAmountInCoreData(totalUpdateVal: String) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let updateAmount = NSEntityDescription.insertNewObject(forEntityName: "Objective", into: context)
        updateAmount.setValue(totalUpdateVal, forKey: "updateAmount")
        
        context.delete(updateAmount)
        objective?.updateAmount = totalUpdateVal
        
        do {
            try context.save()
            
        } catch let saveErr {
            print("Failed to save company:", saveErr)
        }
        enterProgressTextField.text = nil
        self.viewDidLoad()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.extraLightBlue
        
        setProgress()
        
        setupUI()
        
//        guard let currentValue = objective?.updateAmount else {return}
//        let currentVal = Double(currentValue)
//        guard let currentDouble = currentVal else { return }
//        guard let capValue = objective?.amount else {return}
//        let capVal = Double(capValue)
//        guard let capDouble = capVal else { return }
//
//        if(currentDouble >= capDouble){
//            view.addSubview(gratsLabel)
//            gratsLabel.anchor(top: progressView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 50, paddingBottom: 0, paddingRight: 50, width: 0, height: 40)
//        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Reset Progress", style: .plain, target: self, action: #selector(handleResetProgress))
    }
    
    var delegate: CreateObjectiveControllerDelegate?
    
    @objc func handleResetProgress() {
        updateAmountInCoreData(totalUpdateVal: "0")
    }
    
    let taskLabel: UILabel = {
        let label = UILabel()
        label.textColor = .mainDarkGray
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let unitLabel: UILabel = {
        let label = UILabel()
        label.textColor = .mainLightGray
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    private func setupUI() {
        view.addSubview(enterProgressTextField)
        enterProgressTextField.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 32, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(line)
        line.anchor(top: nil, left: view.leftAnchor, bottom: enterProgressTextField.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 50, paddingBottom: -8, paddingRight: 50, width: 0, height: 1)
        
        view.addSubview(currentProgress)
        currentProgress.anchor(top: line.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(updateButton)
        updateButton.anchor(top: currentProgress.bottomAnchor, left: line.leftAnchor, bottom: nil, right: line.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 40)
        
        view.addSubview(taskLabel)
        taskLabel.anchor(top: updateButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 36, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(progressView)
        progressView.anchor(top: taskLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 8, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 40)
        
        view.addSubview(capNumber)
        capNumber.anchor(top: progressView.bottomAnchor, left: nil, bottom: nil, right: progressView.rightAnchor, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(unitLabel)
        unitLabel.anchor(top: capNumber.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 2, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(purposeLabel)
        purposeLabel.anchor(top: unitLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 32, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}


extension UIProgressView {
    
    func animate(currentPercent: Float,duration: Double) {
        
        setProgress(currentPercent, animated: true)
        
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveLinear, animations: {
            self.setProgress(currentPercent, animated: true)
        }, completion: nil)
    }
}

