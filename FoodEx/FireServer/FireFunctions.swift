//
//  FireFunctions.swift
//  FoodEx
//
//  Created by Ivan Taranov on 3/30/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation
import Firebase

class FireFunctions {
    
    enum Function : String {
        case createNewChatSession
        case createNewCustomer
        case sendNewMessage
    }
    
    static var functions = Functions.functions()
 
    class func callFunction(_ function: Function, _ data: Any) {
        functions.httpsCallable(function.rawValue).call(data) { (result, error) in
            if let error = error as NSError? {
                if error.domain == FunctionsErrorDomain {
                    let code = FunctionsErrorCode(rawValue: error.code)
                    let message = error.localizedDescription
                    let details = error.userInfo[FunctionsErrorDetailsKey]
                }
                // ...
            }
//            if let text = (result?.data as? [String: Any])?["text"] as? String {
//                self.resultField.text = text
//            }
        }

    }
}
