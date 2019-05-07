//
//  UI.swift
//  FoodEx
//
//  Created by Ivan Taranov on 3/24/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation
import UIKit

class UI {
    
    enum Page : Int {
        case Login
        case Verification
        case SetName
        case SetGender
        case SetWeight
        case SetGrowth
        case SetBirthday
        
        case RootMain
        case HomeTabs
        case Dashboard
        case Weight
        case Manager
        case Payment
        case Profile
        case Settings
        
        var str: String {
            return "\(self)"
        }
        
        var storyboardId: String {
            return "\(self)VC"
        }
    }
    
    enum PopUp : Int {
        case Rating
        
        var str: String {
            return "\(self)"
        }
        
        var storyboardId: String {
            return "\(self)VC"
        }

    }
    
    
    enum Storyboard : String {
        case Signing
        case Main
        
        var instance : UIStoryboard {
            return UIStoryboard(name: self.rawValue, bundle: nil)
        }
    }
    
    private static var currentPopUp: UIViewController? = nil
    
    static func showPage(source: UIViewController, page: Page) {
        let storyboard: UIStoryboard
        
        if page.rawValue <= Page.SetBirthday.rawValue {
            storyboard = Storyboard.Signing.instance
        } else {
            storyboard = Storyboard.Main.instance
        }
        
        let viewControllerMainMenu = storyboard.instantiateViewController(withIdentifier : page.storyboardId)
        
        //source.present(viewControllerMainMenu, sender: source)
        source.show(viewControllerMainMenu, sender: source) // use this to make navigation bar work (e.g. profile -> settings -> profile)
    }
    
    
    
    static func showPopUp(source: UIViewController, popUp: PopUp) {
        let storyboard: UIStoryboard
        

        storyboard = Storyboard.Main.instance
        
        let popUpVC = storyboard.instantiateViewController(withIdentifier : popUp.storyboardId)
        source.addChild(popUpVC)
        popUpVC.view.frame = source.view.frame
        source.view.addSubview(popUpVC.view)
        
        popUpVC.didMove(toParent: source)
        
        popUpVC.view.transform = CGAffineTransform(scaleX: 1.35, y: 1.35)
        popUpVC.view.alpha = 0.0
        
        UIView.animate(withDuration: 0.24) {
            popUpVC.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            popUpVC.view.alpha = 1.0
        }
        
        currentPopUp = popUpVC
    }
    
    
    
    static func hideCurrentPopUp() {
        
        if currentPopUp == nil {
            return
        }
        UIView.animate(withDuration: 0.24, animations: {
        currentPopUp!.view.transform = CGAffineTransform(scaleX: 1.35, y: 1.35)
        currentPopUp!.view.alpha = 0.0
        }) { _ in
            currentPopUp!.view.removeFromSuperview()
            
            currentPopUp = nil
        }
        
    }
}
