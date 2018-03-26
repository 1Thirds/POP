//
//  SelectIconCollectionViewController.swift
//  TVCCYA
//
//  Created by James Frys on 3/23/18.
//  Copyright © 2018 James Frys. All rights reserved.
//

import UIKit
import CoreData

class SelectIconCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var delegate: CreateObjectiveControllerDelegate?
    
    var icons = [SelectIconCell]()
    
    var cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.mainLightBlue
        
        navigationItem.title = "Select Icon"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Select", style: .plain, target: self, action: #selector(handleSelect))
        
        collectionView?.register(SelectIconCells.self, forCellWithReuseIdentifier: cellId)
        
        setupCells()
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleSelect() {
        dismiss(animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return icons.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SelectIconCells
        
        cell.selectIconCell = icons[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 50, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
    
    // width between cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return ((view.frame.width / 3) / 3) - 6
    }
    
    // padding between cells and physical phone screen bounds
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 24, left: 12, bottom: 8, right: 12)
    }
    
    var icon: SelectIconCell?
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        icon = icons[indexPath.row]
    }
}
