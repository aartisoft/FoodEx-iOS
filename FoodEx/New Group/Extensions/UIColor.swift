//
//  UIColor.swift
//  FoodEx
//
//  Created by Ivan Taranov on 3/31/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import UIKit

extension UIColor {
    static let primary = UIColor(hex: 0x3ECD8E)
    static let primaryLight = UIColor(hex: 0x7DCC90)
    static let primaryLighter = UIColor(hex: 0xA6E4B5)
    static let primaryDark = UIColor(hex: 0x35AA72)
    static let darkGrayKor = UIColor(hex: 0x444444)
    static let lightGrayKor = UIColor(hex: 0xAAAAAA)
    
    convenience init(hex value: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((value & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((value & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(value & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}
