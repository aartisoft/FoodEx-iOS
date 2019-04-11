//
//  StringExtension.swift
//  dubsocial
//
//  Created by Ivan Taranov on 12/21/18.
//  Copyright © 2018 KorLab. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return substring(from: fromIndex)
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return substring(to: toIndex)
    }
    
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return substring(with: startIndex..<endIndex)
    }
}

extension String {
    
    var localized: String {
        //let a = Bundle.localizedBundle.localizedString(forKey: self, value: nil, table: nil)
        let a = NSLocalizedString(self, tableName: nil, bundle: Bundle.main, comment: "")
        return a
    }
}

extension Bundle {
    //Here magic happens
    //when you localize resources: for instance Localizable.strings, images
    //it creates different bundles
    //we take appropriate bundle according to language
    static var localizedBundle: Bundle {
        let languageCode = LanguageManager.getLanguage().rawValue
        guard let path = Bundle.main.path(forResource: languageCode, ofType: "lproj") else {
            return Bundle.main
        }
        return Bundle(path: path)!
    }
}
