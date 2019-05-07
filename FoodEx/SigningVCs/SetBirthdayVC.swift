//
//  BirthdayView.swift
//  FoodEx
//
//  Created by Ivan Taranov on 3/24/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation
import UIKit

class SetBirthdayVC : UIViewController {
    
    @IBOutlet weak var birthdayPicker: UIDatePicker!
    
    @IBAction func onContinueClicked(_ sender: Any) {
        UserData.seMyNewBirthday(newBirthday: birthdayPicker.date)
        
//            let jsonEncoder = JSONEncoder()
//            let jsonData = try jsonEncoder.encode(UserData.my)
//            let json = String(data: jsonData, encoding: String.Encoding.utf8)
        FireFunctions.callFunction(.createNewCustomer, UserData.my.dict)

        UI.showPage(source: self, page: UI.Page.RootMain)
    }
}
