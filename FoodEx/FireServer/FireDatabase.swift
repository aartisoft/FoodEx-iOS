//
//  FireDatabase.swift
//  FoodEx
//
//  Created by Ivan Taranov on 3/30/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation
import Firebase


class FireDatabase {
    
    var db: Firestore
    
    private init() {
        FirebaseApp.configure()
        
        db = Firestore.firestore()
    }
    
//    class func writeValue()
}
