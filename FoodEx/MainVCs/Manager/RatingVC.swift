//
//  RatingVC.swift
//  FoodEx
//
//  Created by korsour on 4/17/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation
import UIKit

class ManagerRatingVC : KeyboardVC {
    
    @IBOutlet weak var feedbackText: UITextView!
    @IBOutlet weak var popUpView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        
        viewsToMove[popUpView] = 0.4
        viewsToDismissKeyboard.append(feedbackText)
        
        HomeTabsVC.shared!.tabBarController!.tabBar.isHidden = true
    }
    
    @IBAction func cancelRating(_ sender: Any) {
        UI.hideCurrentPopUp()
        
        HomeTabsVC.shared!.tabBarController!.tabBar.isHidden = false
    }
}
