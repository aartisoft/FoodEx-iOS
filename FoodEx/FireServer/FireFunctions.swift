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
        case getDayMeal
        case getMyData
        case updateCustomerInfo
        case getMonthDays
        case submitServiceFeedback
        case submitDietDayFeedback
        case getMyWeightHistory
        case isMyCustomerAccountExists
        case saveNewWeightRecording
    }
    
    static var functions = Functions.functions()
 
    class func callFunction(_ function: Function, _ data: Any, callback: @escaping ([String: Any]) -> Void) {
        functions.httpsCallable(function.rawValue).call(data) { (result, error) in
            if let error = error as NSError? {
                if error.domain == FunctionsErrorDomain {
                    let code = FunctionsErrorCode(rawValue: error.code)
                    let message = error.localizedDescription
                    let details = error.userInfo[FunctionsErrorDetailsKey]
                    
                    print(code)
                    print(message)
                    print(details)
                }
                // ...
            }
            print("Data received: " + function.rawValue)
            let dictResponse = result?.data as? [String: Any]
            callback(dictResponse!)
        }
    }
    
    class func callFunction(_ function: Function, _ data: Any) {
       
        functions.httpsCallable(function.rawValue).call(data) { (result, error) in
            if let error = error as NSError? {
                if error.domain == FunctionsErrorDomain {
                    let code = FunctionsErrorCode(rawValue: error.code)
                    let message = error.localizedDescription
                    let details = error.userInfo[FunctionsErrorDetailsKey]
                }
            }
        }
    }
}
