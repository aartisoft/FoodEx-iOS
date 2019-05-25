//
//  Contact.swift
//  FoodEx
//
//  Created by korsour on 5/14/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation

class Contact : Codable {
    var email: String
    var phones: [String]
    
    init(email: String, phones: [String]) {
        self.email = email
        self.phones = phones
    }
}
