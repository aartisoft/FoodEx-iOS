//
//  Delivery.swift
//  FoodEx
//
//  Created by korsour on 5/14/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation

class Delivery : Codable {
    
    enum PackageType : Int, Codable {
        case Bag
        case Cart
        case Package
        
        var str: String {
            return "\(self)"
        }
    }
    
    var time: String
    var type: PackageType
    var note: String
    var address: Address
    
    init(time: String, address: Address, type: PackageType, note: String) {
        self.time = time
        self.address = address
        self.type = type
        self.note = note
    }
    
    
}
