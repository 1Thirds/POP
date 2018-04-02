//
//  SelectIconCells.swift
//  TVCCYA
//
//  Created by James Frys on 3/23/18.
//  Copyright © 2018 James Frys. All rights reserved.
//

import UIKit

class SelectIconCells: UICollectionViewCell {
    
    override var isSelected: Bool{
        didSet {
            if self.isSelected
            {
                self.transform = CGAffineTransform(scaleX: 1.825, y: 1.825)
//                self.contentView.backgroundColor = UIColor.mainLightGreen
//                self.checkmarkImageView.isHidden = false
            } else {
                self.transform = CGAffineTransform.identity
//                self.contentView.backgroundColor = UIColor.clear
//                self.checkmarkImageView.isHidden = true
            }
        }
    }
    
    var selectIconCell: SelectIconCell? {
        didSet {
            if let image = selectIconCell?.image {
                iconImage.image = UIImage(named: image)
            }
            if let name = selectIconCell?.name {
                iconName.text = name
            }
        }
    }
    
    let iconImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        return iv
    }()
    
    let iconName: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let checkmarkImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "checkmark").withRenderingMode(.alwaysOriginal))
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isHidden = true
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(iconImage)
        iconImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: frame.width)
        
//        addSubview(iconName)
//        iconName.anchor(top: iconImage.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
//        
//        iconName.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(checkmarkImageView)
        checkmarkImageView.anchor(top: iconImage.topAnchor, left: iconImage.leftAnchor, bottom: iconImage.bottomAnchor, right: iconImage.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
