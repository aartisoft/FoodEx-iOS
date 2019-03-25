//
//  BirthdayView.swift
//  FoodEx
//
//  Created by Ivan Taranov on 3/24/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation
import UIKit

class BirthdayView : ViewController {
    
    @IBOutlet weak var birthdayPicker: UIDatePicker!
    
    @IBAction func onContinueClicked(_ sender: Any) {
        MyUserData.setNewBirthday(newBirthday: birthdayPicker.date)
        
        UI.ShowStoryboard(UI.Storyboard.Main)
    }
}
