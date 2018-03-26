//
//  SelectIconExtension.swift
//  TVCCYA
//
//  Created by James Frys on 3/23/18.
//  Copyright © 2018 James Frys. All rights reserved.
//

import UIKit

class SelectIconCell: NSObject {
    var name: String?
    var image: String?
}

extension SelectIconCollectionViewController {
    
    func setupCells() {
        
        let workout = SelectIconCell()
        workout.name = "workout"
        workout.image = "workout"
        
        let book = SelectIconCell()
        book.name = "book"
        book.image = "book"
        
        let laptop = SelectIconCell()
        laptop.name = "laptop"
        laptop.image = "laptop"
        
        let gaming = SelectIconCell()
        gaming.name = "gaming"
        gaming.image = "gaming"
        
        let tv = SelectIconCell()
        tv.name = "tv"
        tv.image = "tv"
        
        let groceries = SelectIconCell()
        groceries.name = "groceries"
        groceries.image = "groceries"
        
        let garden = SelectIconCell()
        garden.name = "garden"
        garden.image = "garden"
        
        let cooking = SelectIconCell()
        cooking.name = "cooking"
        cooking.image = "cooking"
        
        let writing = SelectIconCell()
        writing.name = "writing"
        writing.image = "writing"
        
        let heart = SelectIconCell()
        heart.name = "heart"
        heart.image = "heart"
        
        let cash = SelectIconCell()
        cash.name = "cash"
        cash.image = "cash"
        
        let build = SelectIconCell()
        build.name = "build"
        build.image = "build"
        
        let dog = SelectIconCell()
        dog.name = "dog"
        dog.image = "dog"
        
        icons = [workout, book, laptop, gaming, tv, groceries, garden, cooking, writing, heart, cash, build, dog]
    }
}
