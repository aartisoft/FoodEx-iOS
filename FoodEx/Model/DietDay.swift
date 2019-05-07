//
//  DietDay.swift
//  FoodEx
//
//  Created by korsour on 4/27/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation

class DietDay {
    var meals: [Meal] = []
    
    init() {}
    
    init(dict: [String: Any]) {
        let mealsArray = dict["meals"] as! [Any]
        
        for some in mealsArray {
            let newDict = some as! [String: Any]
            let dayTime = Meal.DayTime(rawValue: newDict["dayTime"] as! Int)!
            let dishesArray = newDict["dishes"] as! [Any]
            
            var dishes: [Dish] = []
            
            for someNew in dishesArray {
                let dishDict = someNew as! [String: Any]
                
                let dish = Dish()
                dish.calories = dishDict["calories"] as! Int
                dish.carbo = dishDict["carbo"] as! Int
                dish.fats = dishDict["fats"] as! Int
                dish.name = dishDict["name"] as! String
                dish.proteins = dishDict["proteins"] as! Int
            dish.weight = dishDict["weight"] as! Int
                dish.dishType = Dish.DishType(rawValue: dishDict["dishType"] as! Int)!
                
                dishes.append(dish)
            }
            
            let meal = Meal(dayTime: dayTime, dishes: dishes)
            
            meals.append(meal)
        }
    }
}
