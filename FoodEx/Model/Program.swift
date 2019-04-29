//
//  Program.swift
//  FoodEx
//
//  Created by korsour on 4/28/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import UIKit

class Program {
    var name: String = ""
    var shortDescription: String = ""
    var image: UIImage
    
    var price: Int = 0
    
    init(name: String, shortDescription: String, image: UIImage) {
        self.name = name
        self.shortDescription = shortDescription
        self.image = image
    }
}
