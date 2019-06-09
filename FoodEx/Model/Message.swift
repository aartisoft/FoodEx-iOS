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
    var senderId: String? { get }
    var userType: Int { get }
    var sentDate: Date? { get }
    var name: Name { get } 
}

class MessageText : MessageProtocol, Codable {
    
    var sentDate: Date?
    var messageId: String?
    var senderId: String?
    var userType: Int
    var text: String
    var name: Name
    
    init(text: String) {
        self.sentDate = nil
        self.messageId = nil
        self.senderId = nil
        self.userType = 0 // 0 - customer, 1 - support
        self.text = text
        self.name = Name(first: "", middle: "", last: "")
    }
    
    
    init(text: String, sentDate: Date, messageId: String, senderId: String, userType: Int, name: Name) {
        self.text = text
        self.sentDate = sentDate
        self.messageId = messageId
        self.senderId = senderId
        self.userType = userType // 0 - customer, 1 - support
        self.name = name
    }
    
    var dict: [String: Any] {
        return
            ["messageId": messageId,
             "senderId": senderId,
             "userType": userType,
             "text": text,
             "sentDate": sentDate?.timeIntervalSince1970
        ]
    }
    
    var mockMessage: MockMessage {
        return MockMessage(text: text, sender: Sender(senderId: senderId!, displayName: name.first), messageId: String(sentDate!.timeIntervalSince1970), date: sentDate!)
    }
}
