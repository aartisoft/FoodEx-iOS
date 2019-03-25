//
//  LanguageManager.swift
//  dubsocial
//
//  Created by Ivan Taranov on 12/26/18.
//  Copyright © 2018 KorLab. All rights reserved.
//

import Foundation
import UIKit

class LanguageManager {
    private static let appleLanguagesKey = "AppleLanguages"
    
    
    enum Language: String {
        case English = "en"
        case Spanish = "es"
        case Italian = "it"
    }
        
    static func getLanguage() -> Language {
        if let languageCode = UserDefaults.standard.string(forKey: appleLanguagesKey),
            let language = Language(rawValue: languageCode) {
            return language
        } else {
            let preferredLanguage = NSLocale.preferredLanguages[0] as String
            let index = preferredLanguage.index(
                preferredLanguage.startIndex,
                offsetBy: 2
            )
            guard let localization = Language(
                rawValue: preferredLanguage.substring(to: index)
                ) else {
                    return Language.English
            }
            
            return localization
        }
    }
    
    static func setLanguage(newLanguage: Language) {
        
        guard getLanguage() != newLanguage else {
            return
        }
        
        //change language in the app
        //the language will be changed after restart
        UserDefaults.standard.set([newLanguage.rawValue], forKey: appleLanguagesKey)
        UserDefaults.standard.synchronize()
        
        //initialize the app from scratch
        //show initial view controller
        //so it seems like the is restarted
        //NOTE: do not localize storboards
        //After the app restart all labels/images will be set
        //see extension String below
//        let path = Bundle.main.path(forResource: newLanguage.rawValue, ofType: "lproj")
//        let bundle = Bundle(path: path!)
//        let delegate = UIApplication.shared.delegate as! AppDelegate
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        delegate.window?.rootViewController = (storyboard.instantiateInitialViewController())
        
        UIApplication.shared.windows[0].rootViewController = UIStoryboard(
        name: "Main", bundle: nil).instantiateInitialViewController()
    }
}
