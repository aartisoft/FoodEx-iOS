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
    
    init(dict: [String: Any]) {
        self.title = dict["title"] as! String
        self.startTime = Date(timeIntervalSince1970: Double(dict["startTime"] as! Int))
        if let val = dict["registration"] as? Int{
            self.endTime = Date(timeIntervalSince1970: Double(val))
        }
        self.customerId = dict["customerId"] as! String
        self.supportId = dict["supportId"] as? String ?? "supportIdHere"
    }
}
