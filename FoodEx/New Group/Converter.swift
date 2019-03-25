//
//  Converter.swift
//  dubsocial
//
//  Created by Ivan Taranov on 12/21/18.
//  Copyright © 2018 KorLab. All rights reserved.
//

import Foundation

class Converter {
    
    static func stringToDateComponents(dateString: String) -> DateComponents {
        let dateComponents = DateComponents()
        //dateComponents.year = dateString.prefix(5)
        //dateComponents.month = dateString.
        
        return dateComponents
    }
    
    static func timeStampToDateString(unixtimeInterval: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(unixtimeInterval))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "MM/dd/yyyy" //Specify your format that you want
        return dateFormatter.string(from: date)
    }
    
    
    static func timeStampToDate(unixtimeInterval: Int) -> Date {
        return Date(timeIntervalSince1970: TimeInterval(unixtimeInterval))
    }
    
    static func convertPhoneToStandard(phone: String) -> String {
        if phone.substring(to: 2) == "00" {
            return "+" + phone.substring(from: 2)
        } else if phone.substring(to: 1) != "+" {
            return "+" + phone
        } else {
            return phone
        }
    }
}
