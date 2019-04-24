//
//  UITabBarItem.swift
//  FoodEx
//
//  Created by korsour on 4/11/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation
import UIKit

extension UITabBarItem {
    
    @IBInspectable var stringId: String {
        set(value) {
            self.title = value.localized
        }
        get {
            return ""
        }
    }
}
