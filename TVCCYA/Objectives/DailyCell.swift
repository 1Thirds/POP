//
//  DailyCell.swift
//  TVCCYA
//
//  Created by James Frys on 3/29/18.
//  Copyright © 2018 James Frys. All rights reserved.
//

import UIKit
import CoreData

class DailyCell: UITableViewCell {
    
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
        }
    }
    
    var delegate: CreateObjectiveControllerDelegate?
    
    var objectivesController: ObjectivesController?
    
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
    
//    @objc func handleTextInputChange() {
//        let unitHasText = objTextField.text?.count ?? 0 > 0
//        
//        if unitHasText {
//            self.objectivesController?.navRightDoneButtonShown()
//        } else {
//            self.objectivesController?.navRightNothing()
//        }
//    }
    
    lazy var slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.isContinuous = true
        slider.addTarget(self, action: #selector(sliderValueDidChange(_:)), for: .valueChanged)
        slider.thumbTintColor = UIColor.extraLightBlue
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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.cellBlue
        
        selectionStyle = .none
        
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
