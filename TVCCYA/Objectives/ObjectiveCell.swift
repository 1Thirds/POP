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
            if(value <= 30) {slider.tintColor = UIColor.green}
            else if(value > 30 && value < 70) {slider.tintColor = UIColor.yellow}
            else if(value >= 70 && value < 100) {slider.tintColor = UIColor.red}
            else if(value == 100) {slider.tintColor = UIColor.black}
            slider.setSliderValue(value: value, duration: 2.0)
        }
    }
    
    let objectiveLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
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
    @objc func sliderValueDidChange(_ sender:UISlider!)
    {
        //print("Slider Value--\(sender.value)")
        if(sender.value <= 30) {sender.tintColor = UIColor.green}
        if(sender.value > 30 && sender.value < 70) {sender.tintColor = UIColor.yellow}
        if(sender.value >= 70 && sender.value < 100) {sender.tintColor = UIColor.red}
        if(sender.value == 100) {sender.tintColor = UIColor.black}
        
        sender.setValue(sender.value, animated: true)
        saveSlider(sender: sender.value)
        
    }
    
    //    func reloadRows(indexPath: [IndexPath]){
    //        tableView.reloadRows(indexPath: indexPath)
    //    }
    
    //let companyCell = UIApplication.shared.delegate as! CompanyCell
    
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
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Objective")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                //print(data.value(forKey: "priority") as! Float)
                //print(data.value(forKey: "sliderReload") as! Bool)
            }
            
        } catch {
            
            print("Failed")
        }
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.cellBlue
        
        addSubview(iconImageView)
        iconImageView.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 30, height: 30)
        iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(objectiveLabel)
        objectiveLabel.anchor(top: topAnchor, left: iconImageView.rightAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 125, height: 0)
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
