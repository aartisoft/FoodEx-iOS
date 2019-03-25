//
//  UIVIewExtension.swift
//  FoodEx
//
//  Created by Ivan Taranov on 3/23/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func fadeIn(_ duration: TimeInterval? = 0.4, onCompletion: (() -> Void)? = nil) {
        self.alpha = 0
        self.isHidden = false
        UIView.animate(withDuration: duration!,
                       animations: { self.alpha = 1 },
                       completion: { (value: Bool) in
                        if let complete = onCompletion { complete() }
        }
        )
    }
    
    func fadeOut(_ duration: TimeInterval? = 0.4, onCompletion: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration!,
                       animations: { self.alpha = 0 },
                       completion: { (value: Bool) in
                        self.isHidden = true
                        if let complete = onCompletion { complete() }
        }
        )
    }
}
