//
//  PhoneNumber.swift
//  FoodEx
//
//  Created by korsour on 4/18/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation

class PhoneNumber {
    var phoneValid: String = ""
    
    var phoneFormatted: String {
        get {
            return "+" + phoneValid.substring(with: 0..<2) + " (" + phoneValid.substring(with: 2..<5) + ") " + phoneValid.substring(with: 5..<8) + "-" + phoneValid.substring(with: 8..<10) + "-" + phoneValid.substring(with: 10..<12);
        }
    }
    
    init() {
    }
    
    init(phoneValid: String) {
//        if phoneValid.count != 13 {
//             throw WrongNumber.overflow
//        }
        
        self.phoneValid = phoneValid
    }
}

//enum WrongNumber: Error {
//    case overflow
//}
