//
//  Weight.swift
//  FoodEx
//
//  Created by Ivan Taranov on 3/24/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation

class Weight : Codable {
    var value: Double
    var type: Int
    
    init(value: Double, type: Int) {
        self.value = value
        self.type = type
    }
}
