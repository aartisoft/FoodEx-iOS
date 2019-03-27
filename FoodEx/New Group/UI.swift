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
        
        case Home
        case Weight
        case Manager
        case Payment
        case Profile
        
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
            return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
        }
    }
    
    
    static func ShowPage(source: UIViewController, page: Page) {
        var storyboard: UIStoryboard
        
        if page.rawValue <= Page.SetBirthday.rawValue {
            storyboard = Storyboard.Signing.instance
        } else {
            storyboard = Storyboard.Main.instance
        }
        
        let viewControllerMainMenu = storyboard.instantiateViewController(withIdentifier : page.storyboardId)
        
        source.present(viewControllerMainMenu, animated: true)
    }
    
    
    static func ShowStoryboard(_ storyboard: Storyboard) {
        
    }
}
