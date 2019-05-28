//
//  DietDayRating.swift
//  FoodEx
//
//  Created by korsour on 5/26/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation
import UIKit
import Cosmos

class DietDayRatingVC : KeyboardVC {
    
    static var shared: DietDayRatingVC?
    
    @IBOutlet weak var deliveryRating: CosmosView!
    @IBOutlet weak var foodRating: CosmosView!
    
    @IBOutlet weak var ratingNoteLabel: UILabel!
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var feedbackText: UITextView!
    
    private var date: Date? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DietDayRatingVC.shared = self
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        
        viewsToMove[popUpView] = 0.4
        viewsToDismissKeyboard.append(feedbackText)
        
        ratingNoteLabel.isHidden = true
    
        // TODO: refactor this
        HomeTabsVC.shared!.tabBarController!.tabBar.isHidden = true
    }
    
    @IBAction func cancelRating(_ sender: Any) {
        UI.hideCurrentPopUp()
        
        HomeTabsVC.shared!.tabBarController!.tabBar.isHidden = false
    }
    
    
    @IBAction func submitRating(_ sender: Any) {
        if !validateInput() {
            ratingNoteLabel.fadeIn()
            return
        }
        
        // TODO: make the more correct way to get the date
        let feedback = [
            "deliveryRating": deliveryRating.rating,
            "foodRating": foodRating.rating,
            "comment": feedbackText.text,
            "date": Date().timeIntervalSince1970
            ] as [String : Any]
        
        FireFunctions.callFunction(.submitDietDayFeedback, feedback)
        
        UI.hideCurrentPopUp()
        
        let alert = UIAlertController(title: "Done", message: "Thank you for your feedback. You help us make our job better!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cheers", style: UIAlertAction.Style.default, handler: nil))
       
        HomeTabsVC.shared!.tabBarController!.tabBar.isHidden = false
    }
    
    func validateInput() -> Bool {
        return deliveryRating.rating > 0 && foodRating.rating > 0
    }
    
    func setFeedbackDate(newDate: Date) {
        self.date = newDate
    }
}

