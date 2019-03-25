//
//  WeightView.swift
//  FoodEx
//
//  Created by Ivan Taranov on 3/23/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation
import UIKit

class WeightVC : UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
    
    @IBOutlet weak var weightPicker: UIPickerView!
    var weightValues0: [Int] = []
    var weightValues1: [Int] = []
    var weightTypes: [String] = ["kg", "lb"]
    
    var currentWeight: Int = 40
    var currentWeightType: Int = 0
    
    let kgLb_factor = 2.20462
    let minKg = 40
    let maxKg = 130
    var minLb: Int
    var maxLb: Int
    let defaultKg = 60
    
    required init?(coder aDecoder: NSCoder) {
        self.minLb = Int(Double(minKg) * kgLb_factor)
        self.maxLb = Int(Double(maxKg) * kgLb_factor)
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in minKg...maxKg {
            weightValues0.append(i)
        }
        
        for i in minLb...maxLb {
            weightValues1.append(i)
        }
        
        weightPicker.reloadAllComponents()
        self.weightPicker.delegate = self
        self.weightPicker.dataSource = self
        
//        pickerView(weightPicker, didSelectRow: 19, inComponent: 0)
//        pickerView(weightPicker, didSelectRow: 0, inComponent: 1)
        weightPicker.selectRow(defaultKg - minKg, inComponent: 0, animated: false)
    }

    @IBAction func onContinueClicked(_ sender: Any) {
        MyUserData.setNewWeight(newWeight: Weight(value: currentWeight, type: currentWeightType))
        
        UI.ShowPage(source: self, page: UI.Page.Growth)
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            if currentWeightType == 0 {
                return weightValues0.count
            } else {
                return weightValues1.count
            }
            
        } else {
            
            return weightTypes.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0 {
            if currentWeightType == 0 {
                return String(weightValues0[row])
            } else {
                return String(weightValues1[row])
            }
        } else {
            
            return String(weightTypes[row])
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component == 0 {
            if currentWeightType == 0 {
                return currentWeight = weightValues0[row]
            } else {
                return currentWeight = weightValues1[row]
            }
        } else {
            if currentWeightType == row {
                return
            }
            currentWeightType = row
            
            var newWeight: Int
            var newRow: Int
            
            if currentWeightType == 0 {
                newWeight = Int(Double(currentWeight) / kgLb_factor)
                if newWeight < weightValues0[0] {
                    newWeight = weightValues0[0]
                } else if newWeight > weightValues0[weightValues0.count - 1] {
                    newWeight = weightValues0[weightValues0.count - 1]
                }
                newRow = newWeight - weightValues0[0]
            } else {
                newWeight = Int(Double(currentWeight) * kgLb_factor)
                if newWeight < weightValues1[0] {
                    newWeight = weightValues1[0]
                } else if newWeight > weightValues1[weightValues1.count - 1] {
                    newWeight = weightValues1[weightValues1.count - 1]
                }
                newRow = newWeight - weightValues1[0]
            }
            weightPicker.reloadAllComponents()
            currentWeight = newWeight
            
            weightPicker.selectRow(newRow, inComponent: 0, animated: false)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var str = ""
        if component == 0 {
            if currentWeightType == 0 {
                str = String(weightValues0[row])
            } else {
                str = String(weightValues1[row])
            }
        } else {
            
            str = weightTypes[row]
        }
        
        let myTitle = NSAttributedString(string: str, attributes: [NSAttributedString.Key.font:UIFont(name: "RNS Miles", size: 17.0)!] )
        return myTitle
    }
}
