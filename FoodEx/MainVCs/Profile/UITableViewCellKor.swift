//
//  UITableViewCellKor.swift
//  FoodEx
//
//  Created by korsour on 4/6/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation
import UIKit
import Firebase

@IBDesignable class UITableViewCellKor : UITableViewCell {
    
    @IBInspectable var actionCode: String = ""
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView?.frame = CGRect(x: 30, y: 10, width: 24, height: 24)
        
        self.preservesSuperviewLayoutMargins = false
        self.separatorInset = UIEdgeInsets.zero
        self.layoutMargins = UIEdgeInsets.zero
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.someAction (_:)))
        self.addGestureRecognizer(gesture)
        
    }

    
    @objc func someAction(_ sender:UITapGestureRecognizer){
        switch actionCode {
        case "discount":
            let alert = UIAlertController(title: "Discounts", message: "Discounts will be here soon. Just back to us later ;)", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            ProfileVC.shared!.present(alert, animated: true, completion: nil)
            break
        case "friends":
            // image to share
            let image = #imageLiteral(resourceName: "logo-1")
            let messageStr = """
I invite you to join FoodEx!
            
Join FoodEx Extra and you will be as happy and full of energy as I am Lorem ipsum dolor sit amet.
            
Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
            
Link: https://foodexhub.com.ua
"""
            let activityViewController = UIActivityViewController(activityItems:  [messageStr], applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = ProfileVC.shared!.view // so that iPads won't crash
            
            // exclude some activity types from the list (optional)
//            activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop ]
            activityViewController.excludedActivityTypes = [UIActivity.ActivityType.print, UIActivity.ActivityType.postToWeibo, UIActivity.ActivityType.copyToPasteboard, UIActivity.ActivityType.addToReadingList, UIActivity.ActivityType.postToVimeo, UIActivity.ActivityType.airDrop]
            
            // present the view controller
            ProfileVC.shared!.present(activityViewController, animated: true, completion: nil)
            break
        case "feedback":
            UI.showPopUp(source: ProfileVC.shared!, popUp: .AppRating)
            break
        case "blog":
            let alert = UIAlertController(title: "Blog", message: "Our blog will be here later, don't miss!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            ProfileVC.shared!.present(alert, animated: true, completion: nil)
            break
        case "settings":
            UI.showPage(source: ProfileVC.shared!, page: .Settings)
            break
        case "exit":
            try! Auth.auth().signOut()
            UI.showPage(source: ProfileVC.shared!, page: .Login)
            break
        default:
            return
        }
        
    }
}
