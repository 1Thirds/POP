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
            if(value <= 10) {slider.tintColor = UIColor.mainLightGreen}
            else if(value > 10 && value <= 20) {slider.tintColor = UIColor.sliderGreen}
            else if(value > 20 && value <= 30) {slider.tintColor = UIColor.sliderDarkGreen}
            else if(value > 30 && value <= 40) {slider.tintColor = UIColor.mainLightOrange}
            else if(value > 40 && value <= 50) {slider.tintColor = UIColor.mainOrange}
            else if(value > 50 && value <= 60) {slider.tintColor = UIColor.sliderDarkOrange}
            else if(value > 60 && value <= 70) {slider.tintColor = UIColor.sliderLightRed}
            else if(value > 70 && value <= 80) {slider.tintColor = UIColor.mainRed}
            else if(value > 80 && value <= 90) {slider.tintColor = UIColor.mainDarkRed}
            else if(value > 90 && value <= 100) {slider.tintColor = UIColor.mainDarkRed}
            slider.setSliderValue(value: value, duration: 1.5)
        }
    }
    
    var delegate: CreateObjectiveControllerDelegate?
    
    var objectivesController: ObjectivesController?
    
    lazy var  objectiveLabel: UILabel = {
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
        slider.thumbTintColor = UIColor.extraLightBlue
        return slider
    }()
    
    @objc func sliderValueDidChange(_ sender: UISlider!) {
        
        sliderColorChange(slider: slider)
        
        //sender.setValue(sender.value, animated: true)
        slider.setSliderValue(value: sender.value, duration: 1.5)
        saveSlider(sender: sender.value)
    }
    
    private func sliderColorChange(slider: UISlider) {
        if(slider.value <= 10) {slider.tintColor = UIColor.mainLightGreen}
        else if(slider.value > 10 && slider.value <= 20) {slider.tintColor = UIColor.sliderGreen}
        else if(slider.value > 20 && slider.value <= 30) {slider.tintColor = UIColor.sliderDarkGreen}
        else if(slider.value > 30 && slider.value <= 40) {slider.tintColor = UIColor.mainLightOrange}
        else if(slider.value > 40 && slider.value <= 50) {slider.tintColor = UIColor.mainOrange}
        else if(slider.value > 50 && slider.value <= 60) {slider.tintColor = UIColor.sliderDarkOrange}
        else if(slider.value > 60 && slider.value <= 70) {slider.tintColor = UIColor.sliderLightRed}
        else if(slider.value > 70 && slider.value <= 80) {slider.tintColor = UIColor.mainRed}
        else if(slider.value > 80 && slider.value <= 90) {slider.tintColor = UIColor.mainDarkRed}
        else if(slider.value > 90 && slider.value <= 100) {slider.tintColor = UIColor.mainDarkRed}
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
