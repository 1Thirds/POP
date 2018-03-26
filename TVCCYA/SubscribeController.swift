//
//  SubscribeController.swift
//  TVCCYA
//
//  Created by James Frys on 3/26/18.
//  Copyright © 2018 James Frys. All rights reserved.
//

import UIKit

class SubcscribeController: UIViewController {
    
    let subButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Give us money", for: .normal)
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
        view.backgroundColor = UIColor.extraLightBlue
        
        view.addSubview(subButton)
        subButton.anchor(top: nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 50, paddingBottom: 50, paddingRight: 50, width: 0, height: 50)
    }
}
