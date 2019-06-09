//
//  Chat.swift
//  FoodEx
//
//  Created by korsour on 09.06.2019.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation

class Chat : Codable {
    var title: String
    var startTime: Date
    var endTime: Date? = nil
    var customerId: String
    var supportId: String
    
    init(title: String, startTime: Date, customerId: String, supportId: String) {
        self.title = title
        self.startTime = startTime
        self.customerId = customerId
        self.supportId = supportId
    }
}
