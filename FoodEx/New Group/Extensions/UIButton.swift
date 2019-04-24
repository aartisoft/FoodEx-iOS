//
//  UIButton.swift
//  FoodEx
//
//  Created by korsour on 4/11/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    @IBInspectable var stringId: String {
        set(value) {
            self.titleLabel?.text = value.localized
        }
        get {
            return ""
        }
    }
}
