//
//  UserData.swift
//  FoodEx
//
//  Created by Ivan Taranov on 3/21/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation
import Firebase

class UserData {
    var name: Name? = nil
    var phoneNumber: String? = nil
    var weight: Weight? = nil
    var growth: Growth? = nil
    var gender: Int? = nil
    var birthday: Date? = nil
    var weekdaysDelivery: Delivery? = nil
    var weekendsDelivery: Delivery? = nil
    var contact: Contact? = nil
    var registration: Date? = nil
    
    static var onMyPhoneNumberChanged = Event<String>()
    static var onMyNameChanged = Event<Name>()
    static var onMyWeightChanged = Event<Weight>()
    static var onMyGrowthChanged = Event<Growth>()
    static var onMyGenderChanged = Event<Int>()
    static var onMyBirthdayChanged = Event<Date>()
    
    var dict: [String: Any] {
        return
            ["name": name.dict,
             "phoneNumber": phoneNumber,
             "weight": weight.dict,
             "growth": growth.dict,
             "gender": gender,
             "birthday": birthday?.timeIntervalSince1970,
             "weekdaysDelivery": weekdaysDelivery.dict,
             "weekendsDelivery": weekendsDelivery.dict,
             "contacts": contact.dict
        ]
    }
    
    init(dict: [String: Any]) {
        if let nameDict = dict["name"] as? [String: String] {
            name = Name(first: nameDict["first"]!, middle: nameDict["middle"]!, last: nameDict["last"]!)
        }
        
        if let newPhoneNumber = dict["phoneNumber"] as? String {
            phoneNumber = newPhoneNumber
        }
        
        if let growthDict = dict["growth"] as? [String: Int] {
            growth = Growth(value: growthDict["value"]!, type: growthDict["type"]!)
        }
        
        if let weightDict = dict["weight"] as? [String: Any] {
            weight = Weight(value: weightDict["value"] as! Double, type: weightDict["type"] as! Int)
        }
        
        if let val = dict["registration"] as? Int{
            registration =  Date(timeIntervalSince1970: Double(val))
        }
        
        if let val = dict["birthday"] as? Int{
            birthday =  Date(timeIntervalSince1970: Double(val))
        }
        
        if let val = dict["gender"] as? Int{
            gender = val
        }
        
        if let deliveryDict = dict["weekdaysDelivery"] as? [String: Any] {
            let addressDict = deliveryDict["address"] as? [String: String]
            let address = Address(street: addressDict["street"] as? String ?? "", house: addressDict["house"] as? String ?? "", flat: addressDict["flat"] as? String ?? "")
            weekdaysDelivery = Delivery(time: deliveryDict["time"] as? String ?? "", address: address, type: Delivery.PackageType(rawValue: deliveryDict["type"] as! Int)!, note: deliveryDict["note"] as? String ?? "")
        }
        
        if let deliveryDict = dict["weekendsDelivery"] as? [String: Any] {
            let addressDict = deliveryDict["address"] as? [String: String]
            let address = Address(street: addressDict["street"] as? String ?? "", house: addressDict["house"] as? String ?? "", flat: addressDict["flat"] as? String ?? "")
            weekendsDelivery = Delivery(time: deliveryDict["time"] as? String ?? "", address: address, type: Delivery.PackageType(rawValue: deliveryDict["type"] as! Int)!, note: deliveryDict["note"] as? String ?? "")
        }
        
        if let contactsDict = dict["contacts"] as? [String: Any]{
            contact = Contact(email: contactsDict["email"] as! String, phones: contactsDict["phones"] as! [String])
        }
    }
    
    init() { }

    static var my = UserData()
    
    static func setMyNewPhoneNumber(newPhoneNumber: String) {
        my.phoneNumber = newPhoneNumber
        onMyPhoneNumberChanged.raise(data: newPhoneNumber)
    }
    
    static func setMyNewName(newName: Name) {
        my.name = newName
        onMyNameChanged.raise(data: newName)
    }
    
    static func setMyNewWeight(newWeight: Weight) {
        my.weight = newWeight
        onMyWeightChanged.raise(data: newWeight)
    }
    
    static func setMyNewGrowth(newGrowth: Growth) {
        my.growth = newGrowth
        onMyGrowthChanged.raise(data: newGrowth)
    }
    
    static func setMyNewGender(newGender: Int) {
        my.gender = newGender
        onMyGenderChanged.raise(data: newGender)
    }
    
    static func seMyNewBirthday(newBirthday: Date) {
        my.birthday = newBirthday
        onMyBirthdayChanged.raise(data: newBirthday)
    }
    
    func getGenderName() -> String {
        if gender == 0 {
            return "male"
        } else if gender == 1 {
            return "female"
        } else {
            fatalError("Unexpected gender id")
        }
    }
    
    static func getGenderName(id: Int) -> String {
        if id == 0 {
            return "male"
        } else if id == 1 {
            return "female"
        } else {
            fatalError("Unexpected gender id")
        }
    }
}
