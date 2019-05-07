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
import Firebase

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
            break
        case "C":
            for i in 0...5 {
                symbolsInputs[i].text = ""
            }
            currentPosition = 0
            break
        default:
            if currentPosition < 6 {
                symbolsInputs[currentPosition].text = button.titleLabel?.text
                
                currentPosition += 1
                
                var code: String = ""
                for i in 0...5 {
                    code += symbolsInputs[i].text!
                }
                
                if currentPosition == 6 {
                    CheckCode(code)
                }
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserData.onMyPhoneNumberChanged.addHandler(uniqueName: "phoneNumber-VerificationPage", handler: { (newPhoneNumber: String) in
            self.phoneLabel.text = newPhoneNumber
        })
    }
    
    
    func CheckCode(_ verificationCode: String) {
        
        let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID!,
            verificationCode: verificationCode)
        
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let error = error {
                // ...
                return
            }
            self.onCodeVerified()
        }
    }
    
    func onCodeVerified() {
        UI.showPage(source: self, page: UI.Page.SetName)
    }
}
