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
            purposeText.text = objective?.purpose
            taskText.text = objective?.task
            capNumber.text = objective?.amount
            currentProgress.text = String((objective?.updateAmount)! + "/" + (objective?.amount)!)        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationItem.title = objective?.task
    }
    
    let capNumber: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.mainLightBlue
        label.font = UIFont.boldSystemFont(ofSize: 16)
        //label.textAlignment = .center
        return label
    }()
    
    let taskText: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.mainLightBlue
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let purposeText: UILabel = {
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
    
    let updateAmountTextField: UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Amount", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20), NSAttributedStringKey.foregroundColor: UIColor.mainLightGray])
        tf.textAlignment = .center
        tf.keyboardType = .numberPad
        return tf
    }()
    
    let updateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Update", for: .normal)
        button.backgroundColor = UIColor.mainLightBlue
        button.addTarget(self, action: #selector(handleAmountAdded), for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        return button
    }()
    
    func setProgress(){
        currentProgress.text = String((objective?.updateAmount)! + "/" + (objective?.amount)!)
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
    
    func getCurrentProgress()->String{
        let currentProgress = String((objective?.updateAmount)! + "/" + (objective?.amount)!)
        return currentProgress
    }
    
    let currentProgress: UILabel = {
        let label = UILabel()
        label.textColor = .mainLightGray
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progressTintColor = UIColor.mainOrange
        
        //progressView.setProgress(currentPercent, animated: true)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    @objc func handleAmountAdded() {
        let isFormValid = updateAmountTextField.text?.count ?? 0 > 0
        
        if(isFormValid){
            self.view!.endEditing(true)
            guard let currentValue = objective?.updateAmount else {return}
            let currentVal = Double(currentValue)
            guard let currentDouble = currentVal else { return }
            
            guard let inputValue = updateAmountTextField.text else {return}
            let inputVal = Double(inputValue)
            guard let inputDouble = inputVal else { return }
            
            guard let capValue = objective?.amount else { return }
            let capVal = Double(capValue)
            guard let capDouble = capVal else { return }
            
            let totalUpdateValInt = Int(currentDouble + inputDouble)
            var totalUpdateVal = String(totalUpdateValInt)
            let totalUpdateValDouble = currentDouble + inputDouble
            
            if(totalUpdateValDouble >= capDouble){
                totalUpdateVal = (objective?.amount)!
            }
            
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
            updateAmountTextField.text = nil
            self.viewDidLoad()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.extraLightBlue
        setProgress()
        
        view.addSubview(updateButton)
        updateButton.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 120, paddingLeft: 50, paddingBottom: 50, paddingRight: 50, width: 0, height: 40)
        
        view.addSubview(line)
        line.anchor(top: updateButton.topAnchor, left: updateButton.leftAnchor, bottom: nil, right: updateButton.rightAnchor, paddingTop: -28, paddingLeft: 40, paddingBottom: 50, paddingRight: 40, width: 0, height: 1)
        
        view.addSubview(purposeText)
        purposeText.anchor(top: nil, left: updateButton.leftAnchor, bottom: line.topAnchor , right:updateButton.rightAnchor, paddingTop: 0, paddingLeft: -50, paddingBottom: -205, paddingRight: -50, width: 0, height: 50)
        
        view.addSubview(taskText)
        taskText.anchor(top: nil, left: updateButton.leftAnchor, bottom: line.topAnchor , right:updateButton.rightAnchor, paddingTop: 0, paddingLeft: -50, paddingBottom: 30, paddingRight: -50, width: 0, height: 50)
        
        view.addSubview(updateAmountTextField)
        updateAmountTextField.anchor(top: nil, left: updateButton.leftAnchor, bottom: line.topAnchor , right:updateButton.rightAnchor, paddingTop: 0, paddingLeft: 100, paddingBottom: -10, paddingRight: 100, width: 0, height: 50)
        
        view.addSubview(currentProgress)
        currentProgress.anchor(top: nil, left: updateButton.leftAnchor, bottom: updateButton.topAnchor , right:updateButton.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: -12, paddingRight: 0, width: 0, height: 50)
        
        view.addSubview(progressView)
        progressView.anchor(top: updateButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 30, paddingBottom: 40, paddingRight: 30, width: 0, height: 40)
        
        view.addSubview(capNumber)
        capNumber.anchor(top: progressView.bottomAnchor, left: nil, bottom: nil, right: progressView.rightAnchor, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        guard let currentValue = objective?.updateAmount else {return}
        let currentVal = Double(currentValue)
        guard let currentDouble = currentVal else { return }
        guard let capValue = objective?.amount else {return}
        let capVal = Double(capValue)
        guard let capDouble = capVal else { return }
        
        if(currentDouble >= capDouble){
            view.addSubview(gratsLabel)
            gratsLabel.anchor(top: progressView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 50, paddingBottom: 0, paddingRight: 50, width: 0, height: 40)
        }
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

