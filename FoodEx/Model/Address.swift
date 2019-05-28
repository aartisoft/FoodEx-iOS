//
//  Address.swift
//  FoodEx
//
//  Created by korsour on 5/12/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation

class Address : Codable {
    
    var street: String
    var house: String
    var flat: String
    
    init(street: String, house: String, flat: String) {
        self.street = street
        self.house = house
        self.flat = flat
    }
}
