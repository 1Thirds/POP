//
//  SubscribeController.swift
//  TVCCYA
//
//  Created by James Frys on 3/26/18.
//  Copyright © 2018 James Frys. All rights reserved.
//

import UIKit

class SubcscribeController: UIViewController {
    
    let updateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Subscribe", for: .normal)
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
        
        navigationItem.title = "Subscribe"
        
        view.backgroundColor = UIColor.extraLightBlue
        
        view.addSubview(updateButton)
        updateButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 50, paddingBottom: 50, paddingRight: 50, width: 0, height: 40)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
