//
//  AppRating.swift
//  FoodEx
//
//  Created by korsour on 5/19/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation
import UIKit
import Cosmos

class AppRatingVC : KeyboardVC {
    
    @IBOutlet weak var deliveryRating: CosmosView!
    @IBOutlet weak var foodRating: CosmosView!
    @IBOutlet weak var managerRating: CosmosView!
    @IBOutlet weak var appRating: CosmosView!
    @IBOutlet weak var siteRating: CosmosView!
    
    @IBOutlet weak var ratingNoteLabel: UILabel!
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var feedbackText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        
        viewsToMove[popUpView] = 0.4
        viewsToDismissKeyboard.append(feedbackText)
        
        ratingNoteLabel.isHidden = true
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
        
        let feedback = [
            "deliveryRating": deliveryRating.rating,
            "foodRating": foodRating.rating,
            "managerRating": managerRating.rating,
            "appRating": appRating.rating,
            "siteRating": siteRating.rating,
            "comment": feedbackText.text
            ] as [String : Any]
        
        FireFunctions.callFunction(.submitServiceFeedback, feedback)
        
        UI.hideCurrentPopUp()
        
        let alert = UIAlertController(title: "Done", message: "Thank you for your feedback. You help us make our job better!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cheers", style: UIAlertAction.Style.default, handler: nil))
        
        HomeTabsVC.shared!.tabBarController!.tabBar.isHidden = false
    }
    
    func validateInput() -> Bool {
        return deliveryRating.rating > 0 && foodRating.rating > 0 && managerRating.rating > 0 && appRating.rating > 0 && siteRating.rating > 0
    }
}

