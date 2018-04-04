//
//  ObjectiveCell.swift
//  TVCCYA
//
//  Created by James Frys on 3/27/18.
//  Copyright © 2018 James Frys. All rights reserved.
//

import UIKit
import CoreData

class ObjectiveCell: UITableViewCell {
    
    var objective: Objective? {
        didSet {
            objectiveLabel.text = objective?.task
            
            if let objectiveIcon = objective?.icon {
                iconImageView.image = UIImage(named: objectiveIcon)
            }
            
            guard let value = objective?.priority else { return }
            slider.setValue(00.0, animated: false)
            if(value <= 30) {slider.tintColor = UIColor.mainLightGreen}
            else if(value > 30 && value < 70) {slider.tintColor = UIColor.mainLightOrange}
            else if(value >= 70 && value < 100) {slider.tintColor = UIColor.mainDarkRed}
            else if(value == 100) {slider.tintColor = UIColor.mainBlue}
            slider.setSliderValue(value: value, duration: 2.0)
            
            unitLabel.text = objective?.unit
            
            setupAttributedCurrentProgress()
        }
    }
    
    fileprivate func setupAttributedCurrentProgress() {
        guard let objectiveType = objective?.type else { return }
        
        if objectiveType == "Weekly" {
            attributedTextHelper(color: UIColor.mainLightGreen)
        } else if objectiveType == "Monthly" {
            attributedTextHelper(color: UIColor.mainLightOrange)
        } else if objectiveType == "Yearly" {
            attributedTextHelper(color: UIColor.mainRed)
        }
    }
    
    private func attributedTextHelper(color: UIColor) {
        guard let updateAmount = objective?.updateAmount else { return }
        guard let objectiveAmount = objective?.amount else { return }
        
        let attributedText = NSMutableAttributedString(string: updateAmount, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedStringKey.foregroundColor: color])
        
        attributedText.append(NSAttributedString(string: " / \(objectiveAmount) ", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16), NSAttributedStringKey.foregroundColor: UIColor.white]))
        
        currentProgress.attributedText = attributedText
    }
    
    let objectiveLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        return label
    }()
    
    let iconImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "select"))
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    lazy var slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.isContinuous = true
        slider.addTarget(self, action: #selector(sliderValueDidChange(_:)), for: .valueChanged)
        return slider
    }()
    
    // create a new coreData object with just sliderValue and call it within createCompany()
    @objc func sliderValueDidChange(_ sender:UISlider!) {
        //print("Slider Value--\(sender.value)")
        if(sender.value <= 30) {sender.tintColor = UIColor.mainLightGreen}
        if(sender.value > 30 && sender.value < 70) {sender.tintColor = UIColor.mainLightOrange}
        if(sender.value >= 70 && sender.value < 100) {sender.tintColor = UIColor.mainDarkRed}
        if(sender.value == 100) {sender.tintColor = UIColor.mainBlue}
        
        sender.setValue(sender.value, animated: true)
        saveSlider(sender: sender.value)
        
    }
    
    private func saveSlider(sender : Float){
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        
        let priority = NSEntityDescription.insertNewObject(forEntityName: "Objective", into: context)
        priority.setValue(sender, forKey: "priority")
        
        
        context.delete(priority)
        
        objective?.priority = sender
        
        do {
            try context.save()
        } catch let saveErr {
            print("Failed to save company:", saveErr)
        }
    }
    
    let topContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    let bottomContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    let currentProgress: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let unitLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.cellBlue
        
        addSubview(topContainer)
        topContainer.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 15)
        
        addSubview(iconImageView)
        iconImageView.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 30, height: 30)
        iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(objectiveLabel)
        objectiveLabel.anchor(top: nil, left: iconImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 125, height: 0)
        objectiveLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(bottomContainer)
        bottomContainer.anchor(top: objectiveLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 15)
        
        addSubview(slider)
        slider.anchor(top: nil, left: objectiveLabel.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 4, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        slider.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(unitLabel)
        unitLabel.anchor(top: objectiveLabel.topAnchor, left: nil, bottom: objectiveLabel.bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 4, width: 50, height: 0)
        
        addSubview(currentProgress)
        currentProgress.anchor(top: nil, left: nil, bottom: nil, right: unitLabel.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 4, width: 0, height: 0)
        currentProgress.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension UISlider
{
    ///EZSE: Slider moving to value with animation duration
    public func setSliderValue(value: Float,duration: Double) {
        
        UIView.animate(withDuration: duration, animations: { () -> Void in
            self.setValue(self.value, animated: true)
            
        }) { (bol) -> Void in
            UIView.animate(withDuration: duration, animations: { () -> Void in
                self.setValue(value, animated: true)
            }, completion: nil)
        }
        
    }
}
