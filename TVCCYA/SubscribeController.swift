//
//  SubscribeController.swift
//  TVCCYA
//
//  Created by James Frys on 3/26/18.
//  Copyright © 2018 James Frys. All rights reserved.
//

import UIKit

class SubcscribeController: UIViewController {
    
    let updateAmountLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.mainDarkGray
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Update Amount"
        return label
    }()
    
    let updateAmountTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "###"
        tf.keyboardType = .numberPad
        return tf
    }()
    
    let updateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Update", for: .normal)
        button.backgroundColor = UIColor.mainLightBlue
        button.addTarget(self, action: #selector(handleSub), for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        return button
    }()
    
    @objc func handleSub() {
        print("see ya later fuckin mike")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Update Amount"
        
        view.backgroundColor = UIColor.extraLightBlue
        
        view.addSubview(updateAmountLabel)
        updateAmountLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 50, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 150, height: 50)
        
        view.addSubview(updateAmountTextField)
        updateAmountTextField.anchor(top: updateAmountLabel.topAnchor, left: updateAmountLabel.rightAnchor, bottom: updateAmountLabel.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(updateButton)
        updateButton.anchor(top: updateAmountLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 25, paddingLeft: 50, paddingBottom: 50, paddingRight: 50, width: 0, height: 40)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
