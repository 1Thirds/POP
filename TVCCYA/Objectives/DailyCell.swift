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
            objTextField.text = objective?.task
        }
    }
    
    var delegate: CreateObjectiveControllerDelegate?
    
    var objectivesController: ObjectivesController?
    
    let objTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter task"
//        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    lazy var iconImageView: UIButton = {
        let iv = UIButton(type: .system)
        iv.setImage(#imageLiteral(resourceName: "select_photo_empty"), for: .normal)
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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(iconImageView)
        iconImageView.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 4, paddingBottom: 0, paddingRight: 0, width: 35, height: 35)
        iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(objTextField)
        objTextField.anchor(top: topAnchor, left: iconImageView.rightAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
