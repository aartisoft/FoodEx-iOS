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
        set {
            self.titleLabel?.text = newValue.localized
        }
        get {
            return ""
        }
    }
}
