//
//  UILabel.swift
//  FoodEx
//
//  Created by Ivan Taranov on 3/23/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    func fadeIn(_ text: String? = nil, _ duration: TimeInterval? = 0.4, onCompletion: (() -> Void)? = nil) {
        
        self.text = text
        
        self.fadeIn(duration, onCompletion: onCompletion)
    }
    
    @IBInspectable var stringId: String {
        set(value) {
            self.text = value.localized
        }
        get {
            return ""
        }
    }
}
