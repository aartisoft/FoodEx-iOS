//
//  VerificationView.swift
//  FoodEx
//
//  Created by Ivan Taranov on 3/21/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation
import UIKit
import AudioToolbox

class VerificationVC: UIViewController {
    
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet var symbolsInputs: Array<UILabel>!
    var currentPosition: Int = 0
    
    @IBAction func OnSymbolClicked(_ sender: Any) {
        let button: UIButton = sender as! UIButton
        
        switch button.titleLabel?.text {
        case "<":
            if currentPosition > 0 {
                currentPosition -= 1
                symbolsInputs[currentPosition].text = ""
            }
        case "C":
            for i in 0...5 {
                symbolsInputs[i].text = ""
            }
            currentPosition = 0
        default:
            if currentPosition < 6 {
                symbolsInputs[currentPosition].text = button.titleLabel?.text
                
                currentPosition += 1
                
                if currentPosition == 6 {
                    onCodeVerified()
                }
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        MyUserData.onPhoneNumberChanged.addHandler(uniqueName: "phoneNumber-VerificationPage", handler: { (newPhoneNumber: String) in
            self.phoneLabel.text = newPhoneNumber
        })
    }
    
    
    func onCodeVerified() {
        UI.ShowPage(source: self, page: UI.Page.Name)
    }
}
