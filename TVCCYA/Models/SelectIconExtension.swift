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
        workout.name = "gym"
        workout.image = "gym"
        
        let book = SelectIconCell()
        book.name = "book"
        book.image = "book"
        
        let laptop = SelectIconCell()
        laptop.name = "laptop"
        laptop.image = "laptop"
//
//        let gaming = SelectIconCell()
//        gaming.name = "gaming"
//        gaming.image = "gaming"
//
//        let tv = SelectIconCell()
//        tv.name = "tv"
//        tv.image = "tv"
//
//        let groceries = SelectIconCell()
//        groceries.name = "groceries"
//        groceries.image = "groceries"
//
//        let garden = SelectIconCell()
//        garden.name = "garden"
//        garden.image = "garden"
//
//        let cooking = SelectIconCell()
//        cooking.name = "cooking"
//        cooking.image = "cooking"
//
//        let writing = SelectIconCell()
//        writing.name = "writing"
//        writing.image = "writing"
//
//        let heart = SelectIconCell()
//        heart.name = "heart"
//        heart.image = "heart"
//
//        let cash = SelectIconCell()
//        cash.name = "cash"
//        cash.image = "cash"
//
//        let build = SelectIconCell()
//        build.name = "build"
//        build.image = "build"
//
//        let dog = SelectIconCell()
//        dog.name = "dog"
//        dog.image = "dog"
//
//        let shopping = SelectIconCell()
//        shopping.name = "shopping"
//        shopping.image = "shopping"
//
//        let movie = SelectIconCell()
//        movie.name = "movie"
//        movie.image = "movie"
//
//        let health = SelectIconCell()
//        health.name = "health"
//        health.image = "health"
//
//        let camp = SelectIconCell()
//        camp.name = "camp"
//        camp.image = "camp"
//
//        let drink = SelectIconCell()
//        drink.name = "drink"
//        drink.image = "drink"
//
//        let coffee = SelectIconCell()
//        coffee.name = "coffee"
//        coffee.image = "coffee"
//
//        let haircut = SelectIconCell()
//        haircut.name = "haircut"
//        haircut.image = "haircut"
//
//        let clean = SelectIconCell()
//        clean.name = "clean"
//        clean.image = "clean"
//
//        let laundry = SelectIconCell()
//        laundry.name = "laundry"
//        laundry.image = "laundry"
//
//        let bed = SelectIconCell()
//        bed.name = "bed"
//        bed.image = "bed"
        
        icons = [workout, book, laptop]
    }
}
