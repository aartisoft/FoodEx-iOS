//
//  LoginView.swift
//  FoodEx
//
//  Created by Ivan Taranov on 3/20/19.
//  Copyright © 2019 KorLab. All rights reserved.
//


import UIKit
import Firebase
import InputMask

class LoginVC: UIViewControllerKeyboard {
    
    @IBOutlet weak var phonePrefixLabel: UILabel!
    @IBOutlet weak var listener: MaskedTextFieldDelegate!
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var phoneNote: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        listener.affinityCalculationStrategy = .prefix
        listener.affineFormats = [
            "0[00] [000]-[00]-[00]"
        ]
        
        viewsToMove[continueButton] = 0.65
        viewsToDismissKeyboard.append(phoneText)
        
        phoneNote.isHidden = true
                
//        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange(_: )), name: UITextField.textDidChangeNotification, object: nil)
    }
    
    
//    open func textField(_ textField: UITextField, didFillMandatoryCharacters complete: Bool, didExtractValue value: String) {
//        
//        phoneText.text = value
//        
//        if self.phoneText.text!.count < 10 {
//            continueButton.isEnabled = false
//        } else {
//            continueButton.isEnabled = true
//        }
//    }
    
    
    fileprivate func validate(_ textField: UITextField) -> (Bool, String?) {
    
        guard let text = textField.text else {
            return (false, nil)
        }
        
        if textField == phoneText {
            return (text.count == 13, "signing.phone.error.short".localized)
        }
        
        return (false, nil)
    }
    
//    @objc private func textDidChange(_ notification: Notification) {
//
//    }
    
    
    @IBAction func OnPhoneEntered(_ sender: Any) {
        
        let (valid, message) = validate(phoneText)
        
        if valid {
            self.phoneNote.fadeOut()
        }
        if !valid {
            self.phoneNote.fadeIn()
            phoneNote.text = message
            return
        }
        
        let phone = Converter.convertPhoneToStandard(phone: self.phonePrefixLabel.text! + self.phoneText.text!)
        
        UserData.setMyNewPhoneNumber(newPhoneNumber: phone)
        
        PhoneAuthProvider.provider().verifyPhoneNumber(UserData.my.getPhoneNumber(), uiDelegate: nil) { (verificationID, error) in
            if error != nil {
                let a = error
//                self.showMessagePrompt(error.localizedDescription)
                return
            }

            UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
            UI.ShowPage(source: self, page: UI.Page.Verification)
        }
    }
    

}
