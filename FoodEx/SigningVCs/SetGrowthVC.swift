//
//  WeightView.swift
//  FoodEx
//
//  Created by Ivan Taranov on 3/23/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation
import UIKit

class SetGrowthVC : UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var weightPicker: UIPickerView!
    @IBOutlet var growthImage: UIImageView!
    var growthValues0: [Int] = []
    var growthValues1: [Int] = []
    var growthTypes: [String] = ["cm", "inch"]
    
    var currentGrowth: Int = 40
    var currentGrowthType: Int = 0
    
    let cmInch_factor = 0.393701
    let minCm = 150
    let maxCm = 250
    var minInch: Int
    var maxInch: Int
    var defaultCm: Int
    
    required init?(coder aDecoder: NSCoder) {
        self.minInch = Int(Double(minCm) * cmInch_factor)
        self.maxInch = Int(Double(maxCm) * cmInch_factor)
        defaultCm = 180 - UserData.my.getGenderId() * 10
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in minCm...maxCm {
            growthValues0.append(i)
        }
        
        for i in minInch...maxInch {
            growthValues1.append(i)
        }
        
        
        weightPicker.reloadAllComponents()
        self.weightPicker.delegate = self
        self.weightPicker.dataSource = self
        
//        pickerView(weightPicker, didSelectRow: 19, inComponent: 0)
//        pickerView(weightPicker, didSelectRow: 0, inComponent: 1)
        weightPicker.selectRow(defaultCm - minCm, inComponent: 0, animated: false)
        
        growthImage.image = UIImage(named: UserData.my.getGenderName() + "_growth")
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            if currentGrowthType == 0 {
                return growthValues0.count
            } else {
                return growthValues1.count
            }
            
        } else {
            
            return growthTypes.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0 {
            if currentGrowthType == 0 {
                return String(growthValues0[row])
            } else {
                return String(growthValues1[row])
            }
        } else {
            
            return String(growthTypes[row])
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component == 0 {
            if currentGrowthType == 0 {
                return currentGrowth = growthValues0[row]
            } else {
                return currentGrowth = growthValues1[row]
            }
        } else {
            if currentGrowthType == row {
                return
            }
            currentGrowthType = row
            
            var newWeight: Int
            var newRow: Int
            
            if currentGrowthType == 0 {
                newWeight = Int(Double(currentGrowth) / cmInch_factor)
                if newWeight < growthValues0[0] {
                    newWeight = growthValues0[0]
                } else if newWeight > growthValues0[growthValues0.count - 1] {
                    newWeight = growthValues0[growthValues0.count - 1]
                }
                newRow = newWeight - growthValues0[0]
            } else {
                newWeight = Int(Double(currentGrowth) * cmInch_factor)
                if newWeight < growthValues1[0] {
                    newWeight = growthValues1[0]
                } else if newWeight > growthValues1[growthValues1.count - 1] {
                    newWeight = growthValues1[growthValues1.count - 1]
                }
                newRow = newWeight - growthValues1[0]
            }
            weightPicker.reloadAllComponents()
            currentGrowth = newWeight
            
            weightPicker.selectRow(newRow, inComponent: 0, animated: false)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var str = ""
        if component == 0 {
            if currentGrowthType == 0 {
                str = String(growthValues0[row])
            } else {
                str = String(growthValues1[row])
            }
        } else {
            
            str = growthTypes[row]
        }
        
        let myTitle = NSAttributedString(string: str, attributes: [NSAttributedString.Key.font:UIFont(name: "RNS Miles", size: 17.0)!] )
        return myTitle
    }
    
    
    @IBAction func onContinueClicked(_ sender: Any) {
        UserData.setMyNewGrowth(newGrowth: Growth(value: currentGrowth, type: currentGrowthType))
        
        UI.showPage(source: self, page: UI.Page.SetBirthday)
    }
}
