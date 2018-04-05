//
//  ObjectiveCell.swift
//  TVCCYA
//
//  Created by James Frys on 3/27/18.
//  Copyright © 2018 James Frys. All rights reserved.
//

import UIKit
import CoreData

class CustomUISlider : UISlider {
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        
        //keeps original origin and width, changes height, you get the idea
        let customBounds = CGRect(origin: bounds.origin, size: CGSize(width: bounds.size.width, height: 3.33))
        super.trackRect(forBounds: customBounds)
        return customBounds
    }
}

class ObjectiveCell: UITableViewCell {
    
    var objective: Objective? {
        didSet {
            objectiveLabel.text = objective?.task
            
            if let objectiveIcon = objective?.icon {
                iconImageView.image = UIImage(named: objectiveIcon)
            }
            
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
        
        attributedText.append(NSAttributedString(string: " / \(objectiveAmount) ", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedStringKey.foregroundColor: UIColor.white]))
        
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
        label.textAlignment = .center
        return label
    }()
    
    let unitLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
//        label.numberOfLines = 0
//        label.lineBreakMode = NSLineBreakMode.byWordWrapping
//        label.textAlignment = .left
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
        
        addSubview(unitLabel)
        unitLabel.anchor(top: objectiveLabel.topAnchor, left: nil, bottom: objectiveLabel.bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 4, width: 60, height: 0)
        
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
