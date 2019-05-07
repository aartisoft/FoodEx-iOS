//
//  DishCardRowModel.swift
//  FoodEx
//
//  Created by korsour on 4/23/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation

class Dish: Codable {
    enum DishType : Int, Codable {
        case Salad
        case Soup
        case Hotter
        case Garnish
        case Drink
        case Unknown
        
        var str: String {
            return "\(self)"
        }
    }
    
    var dishType: DishType = DishType.Unknown
    var name: String = ""
    var calories: Int = 0
    var carbo: Int = 0
    var fats: Int = 0
    var proteins: Int = 0
    var weight: Int = 0
    
    
    
    
    init() {
    }
    
    
    init(dishType: DishType, name: String) {
        self.dishType = dishType
        self.name = name
    }
}
