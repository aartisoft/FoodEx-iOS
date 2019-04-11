//
//  UIInputField.swift
//  FoodEx
//
//  Created by korsour on 4/11/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    @IBInspectable var stringId: String {
        set(value) {
            self.placeholder = value.localized
        }
        get {
            return ""
        }
    }
}
