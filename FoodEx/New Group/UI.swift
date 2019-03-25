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
    
    enum Page : String {
        case Phone
        case Verification
        case Name
        case Gender
        case Weight
        case Growth
        case Birthday
    }
    
    
    enum Storyboard : String {
        case Signing
        case Main
        
        var instance : UIStoryboard {
            return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
        }
    }
    
    
    static func ShowPage(source: UIViewController, page: Page) {
        let storyboard = Storyboard.Main.instance
        
        let viewControllerMainMenu = storyboard.instantiateViewController(withIdentifier : page.rawValue + "VC")
        
        source.present(viewControllerMainMenu, animated: true)
    }
    
    
    static func ShowStoryboard(_ storyboard: Storyboard) {
        
    }
}
