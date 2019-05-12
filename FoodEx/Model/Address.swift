//
//  Address.swift
//  FoodEx
//
//  Created by korsour on 5/12/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation

class Address : Encodable {
    
    enum DeliveryType : Int{
        case Bag
        case Cart
        case Package
    }
    
    
    var street: String
    var house: String
    var flat: String
    
    init(street: String, house: String, flat: String) {
        self.street = street
        self.house = house
        self.flat = flat
    }
}
