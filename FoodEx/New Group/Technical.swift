//
//  Technical.swift
//  FoodEx
//
//  Created by korsour on 4/29/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation

class Technical {
    static func callInSeconds(delay: Double, action: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
            action()
        }
    }
}
