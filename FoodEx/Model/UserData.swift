//
//  UserData.swift
//  FoodEx
//
//  Created by Ivan Taranov on 3/21/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation

struct MyUserData {
    private static var phoneNumber: String = ""
    private static var name: Name? = nil
    private static var weight: Weight? = nil
    private static var growth: Growth? = nil
    private static var gender: Int = -1
    private static var birthday: Date? = nil
    
    static var onPhoneNumberChanged = Event<String>()
    static var onNameChanged = Event<Name>()
    static var onWeightChanged = Event<Weight>()
    static var onGrowthChanged = Event<Growth>()
    static var onGenderChanged = Event<Int>()
    static var onBirthdayChanged = Event<Date>()
    
    static func setNewPhoneNumber(newPhoneNumber: String) {
        phoneNumber = newPhoneNumber
        onPhoneNumberChanged.raise(data: newPhoneNumber)
    }
    
    static func setNewName(newName: Name) {
        name = newName
        onNameChanged.raise(data: newName)
    }
    
    static func setNewWeight(newWeight: Weight) {
        weight = newWeight
        onWeightChanged.raise(data: newWeight)
    }
    
    static func setNewGrowth(newGrowth: Growth) {
        growth = newGrowth
        onGrowthChanged.raise(data: newGrowth)
    }
    
    static func setNewGender(newGender: Int) {
        gender = newGender
        onGenderChanged.raise(data: newGender)
    }
    
    static func setNewBirthday(newBirthday: Date) {
        birthday = newBirthday
        onBirthdayChanged.raise(data: newBirthday)
    }
}
