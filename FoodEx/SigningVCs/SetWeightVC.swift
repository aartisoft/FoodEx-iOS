//
//  WeightView.swift
//  FoodEx
//
//  Created by Ivan Taranov on 3/23/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation
import UIKit

class SetWeightVC : UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    static var shared: SetWeightVC?
    
    @IBOutlet var weightImage: UIImageView!
    @IBOutlet weak var weightPicker: UIPickerView!
    var weightValues0: [Double] = []
    var weightValues1: [Double] = []
    var weightTypes: [String] = ["kg", "lb"]
    
    var currentWeight: Double = 0
    var currentWeightType: Int = 0
    
    let kgLb_factor = 2.20462
    let minKg = 40.0
    let maxKg = 130.0
    var minLb: Double
    var maxLb: Double
    var defaultKg: Double
    
    required init?(coder aDecoder: NSCoder) {
        self.minLb = round(minKg * kgLb_factor * 10) / 10
        self.maxLb = round(maxKg * kgLb_factor * 10) / 10
        defaultKg = round(Double(75 - UserData.my.gender! * 10))
        currentWeight = defaultKg
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SetWeightVC.shared = self
        
        for i in stride(from: minKg, to: maxKg, by: 0.1) {
            weightValues0.append(round(i * 10) / 10)
        }
        
        for i in stride(from: minLb, to: maxLb, by: 0.1) {
            weightValues1.append(i)
        }
        
        
        weightPicker.reloadAllComponents()
        self.weightPicker.delegate = self
        self.weightPicker.dataSource = self
        
//        pickerView(weightPicker, didSelectRow: 19, inComponent: 0)
//        pickerView(weightPicker, didSelectRow: 0, inComponent: 1)
        weightPicker.selectRow(Int((defaultKg - minKg) * 10), inComponent: 0, animated: false)
        
        weightImage.image = UIImage(named: UserData.my.getGenderName() + "_weight")
    }

    @IBAction func onContinueClicked(_ sender: Any) {
        UserData.setMyNewWeight(newWeight: Weight(value: currentWeight, type: currentWeightType))
        
        UI.showPage(source: self, page: UI.Page.SetGrowth)
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
            
            var newWeight: Double
            var newRow: Int
            
            if currentWeightType == 0 {
                newWeight = round((currentWeight / kgLb_factor) * 10) / 10
                if newWeight < weightValues0[0] {
                    newWeight = weightValues0[0]
                } else if newWeight > weightValues0[weightValues0.count - 1] {
                    newWeight = weightValues0[weightValues0.count - 1]
                }
                newRow = Int(round((newWeight - weightValues0[0]) * 10))
            } else {
                newWeight = round((currentWeight * kgLb_factor) * 10) / 10
                if newWeight < weightValues1[0] {
                    newWeight = weightValues1[0]
                } else if newWeight > weightValues1[weightValues1.count - 1] {
                    newWeight = weightValues1[weightValues1.count - 1]
                }
                newRow = Int(round((newWeight - weightValues1[0]) * 10))
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
