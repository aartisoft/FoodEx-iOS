//
//  Message.swift
//  FoodEx
//
//  Created by korsour on 09.06.2019.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation
import MessageKit

protocol MessageProtocol {
    var messageId: String? { get }
    var readDate: Date? { get }
    var senderId: String { get }
    var userType: Int { get }
    var sentDate: Date { get }
    var name: Name? { get } 
}

// TODO: sync all data inside here
class MessageText : MessageProtocol, Codable {
    
    var sentDate: Date
    var readDate: Date?
    var messageId: String?
    var senderId: String
    var userType: Int
    var text: String
    var name: Name? = nil
    
    init(text: String) {
        self.sentDate = Date()
        self.messageId = "" // be careful
        self.senderId = "" // be careful
        self.userType = 0 // 0 - customer, 1 - support
        self.text = text
    }
    
    
    init(text: String, sentDate: Date, messageId: String, senderId: String, userType: Int) {
        self.text = text
        self.sentDate = sentDate
        self.messageId = messageId
        self.senderId = senderId
        self.userType = userType // 0 - customer, 1 - support
    }
    
    
    init(dict: [String: Any]) {
        self.sentDate = Date(timeIntervalSince1970: Double(dict["sentDate"] as! Int))
        if let val = dict["readDate"] as? Int{
            self.readDate = Date(timeIntervalSince1970: Double(val))
        }
        self.senderId = dict["senderId"] as! String
        self.userType = dict["userType"] as! Int
        self.messageId = dict["messageId"] as! String
        self.text = dict["text"] as! String
    }
    
    
    var dict: [String: Any] {
        return
            ["messageId": messageId,
             "senderId": senderId,
             "userType": userType,
             "text": text,
             "sentDate": sentDate.timeIntervalSince1970
        ]
    }
    
    var mockMessage: MockMessage {
        return MockMessage(text: text, sender: Sender(senderId: senderId, displayName: "AA"), messageId: String(Int(sentDate.timeIntervalSince1970)), date: sentDate)
    }
}
