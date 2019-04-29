//
//  DishCardModel.swift
//  FoodEx
//
//  Created by korsour on 4/23/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation
import UIKit

class Meal: Codable {
    
    enum DayTime: Int, Codable {
        case Breakfast
        case Brunch
        case Lunch
        case AfternoonMeals
        case SecondAfternoonMeals
        case Dinner
        case Custom
    }
    
    
    static var titles = ["Breakfast", "Brunch", "Lunch", "Afternoon meals", "Second afternoon meals", "Dinner"]
    static var times = ["8:00", "10:00", "12:00", "15:00", "17:00", "19:00"]
    static var icons: [UIImage] = [#imageLiteral(resourceName: "breakfast"), #imageLiteral(resourceName: "brunch"), #imageLiteral(resourceName: "lunch"), #imageLiteral(resourceName: "afternoon_meals"), #imageLiteral(resourceName: "second_afternoon_meals"), #imageLiteral(resourceName: "dinner")]
    static var colors: [UIColor] = [UIColor(hex: 0xFFE58F9F), UIColor(hex: 0xFFE89754), UIColor(hex: 0xFFFFC871), UIColor(hex: 0xFFF46C4D), UIColor(hex: 0xFFA17DA8), UIColor(hex: 0xFF608EC6)]
    
    
    var dayTime: DayTime = DayTime.Custom
    var dishes: [Dish] = []
    
    var title: String {
        get {
            return Meal.titles[dayTime.rawValue]
        }
    }
    
    var time: String {
        get {
            return Meal.times[dayTime.rawValue]
        }
    }
    
    var icon: UIImage {
        get {
            return Meal.icons[dayTime.rawValue]
        }
    }
    
    var color: UIColor {
        get {
            return Meal.colors[dayTime.rawValue]
        }
    }
    
    
    init() {
    }
    
    
    init(dayTime: DayTime, dishes: [Dish]) {
        self.dayTime = dayTime
        self.dishes = dishes
    }
}
