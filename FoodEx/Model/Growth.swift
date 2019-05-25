//
//  Growth.swift
//  FoodEx
//
//  Created by Ivan Taranov on 3/24/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation

class Growth : Codable {
    var value: Int
    var type: Int
    
    init(value: Int, type: Int) {
        self.value = value
        self.type = type
    }
    
    func getString() -> String {
        return String(value) + " " + (type == 0 ? "cm." : "in.")
    }
}
