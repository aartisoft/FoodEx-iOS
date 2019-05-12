//
//  UserData.swift
//  FoodEx
//
//  Created by Ivan Taranov on 3/21/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation

class UserData {
    private var phoneNumber: String? = nil
    private var name: Name? = nil
    private var weight: Weight? = nil
    private var growth: Growth? = nil
    private var gender: Int? = nil
    private var birthday: NSDate? = nil
    private var weekDaysAddress: Address? = nil
    private var weekEndsAddress: Address? = nil
    private var deliveryType: Address.DeliveryType? = nil
    private var deliveryNote: String? = nil
    private var contactPhone: String? = nil
    private var contactEmail: String? = nil
    
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
             "weekDaysAddress": weekDaysAddress?.dict,
             "weekEndsAddress": weekEndsAddress?.dict,
             "deliveryType": deliveryType?.rawValue,
             "deliveryNote": deliveryNote,
             "contactPhone": contactPhone,
             "contactEmail": contactEmail
        ]
    }

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
        my.birthday = newBirthday as NSDate
        onMyBirthdayChanged.raise(data: newBirthday)
    }
    
    func getGenderName() -> String {
        if gender == 0 {
            return "man"
        } else if gender == 1 {
            return "woman"
        } else {
            return "Error"
        }
    }
    
    func getGenderId() -> Int {
        return gender!
    }
    
    func getPhoneNumber() -> String {
        return phoneNumber!
    }
    
    func getName() -> String? {
        return "Ivan Taranov"
        //return name?.first
    }
}
