//
//  DishCardModel.swift
//  FoodEx
//
//  Created by korsour on 4/23/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation

class DishCardModel {
    
    enum DayTime: Int {
        case Breakfast
        case Brunch
        case Lunch
        case AfternoonMeals
        case SecondAfternoonMeals
        case Dinner
        case Custom
    }
    
    
    static var times = ["8:00", "10:00", "12:00", "15:00", "17:00", "19:00"]
    
    
    var title: String = ""
    var description: String = ""
    var dayTime: DayTime = DayTime.Custom
    var dishCardRows: [DishCardRowModel] = []
    
    var time: String {
        get {
            return DishCardModel.times[dayTime.rawValue]
        }
    }
    
    
    
    init() {
    }
    
    
    init(title: String, description: String, time: String, dayTime: DayTime, dishCardRows: [DishCardRowModel]) {
        self.title = title
        self.description = description
        self.dayTime = dayTime
    }
}
