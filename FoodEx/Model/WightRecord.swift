//
//  WightRecord.swift
//  FoodEx
//
//  Created by korsour on 5/28/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation

struct WeightRecord : Codable {
    var weight: Weight
    var date: Date
    
    init(weight: Weight, date: Date) {
        self.weight = weight
        self.date = date
    }
}
