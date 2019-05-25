//
//  FireController.swift
//  FoodEx
//
//  Created by korsour on 5/15/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation

class FireController {
    static func getUserData() {
        FireFunctions.callFunction(.getMyData, "", callback: { (dictResponse) in

            UserData.my = UserData(dict: dictResponse["customerData"] as! [String: Any])
        })
    }
}
