//
//  Name.swift
//  FoodEx
//
//  Created by Ivan Taranov on 3/23/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation

class Name : Codable {
    var first: String
    var middle: String
    var last: String
    
    init() {
        self.first = ""
        self.middle = ""
        self.last = ""
    }
    
    init(first: String, middle: String, last: String) {
        self.first = first
        self.middle = middle
        self.last = last
    }
}
