//
//  NameView
//  FoodEx
//
//  Created by Ivan Taranov on 3/22/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation
import UIKit

class SetNameVC: UIViewControllerKeyboard {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var firstNameText: DesignableUITextField!
    @IBOutlet weak var middleNameText: DesignableUITextField!
    @IBOutlet weak var lastNameText: DesignableUITextField!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var nameNote: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewsToMove[titleLabel] = 0.1
        viewsToMove[firstNameText] = 0.3
        viewsToMove[middleNameText] = 0.3
        viewsToMove[lastNameText] = 0.3
        viewsToMove[nameNote] = 0.4
        viewsToMove[continueButton] = 0.75
        viewsToDismissKeyboard.append(firstNameText)
        viewsToDismissKeyboard.append(lastNameText)
        viewsToDismissKeyboard.append(middleNameText)
        
        nameNote.isHidden = true
    }
    
    
    @IBAction func onContinueCLicked(_ sender: Any) {
        
        var (valid, message) = validate(firstNameText)
        if !valid {
            self.nameNote.fadeIn(message)
            return
        }
        
        (valid, message) = validate(middleNameText)
        if !valid {
            self.nameNote.fadeIn(message)
            return
        }
        
        (valid, message) = validate(lastNameText)
        if !valid {
            self.nameNote.fadeIn(message)
            return
        }
        
        
        let name = Name(first: firstNameText.text!, middle: middleNameText.text!, last: lastNameText.text!)
        
        UserData.setMyNewName(newName: name)
                
        UI.ShowPage(source: self, page: UI.Page.SetGender)
    }
}

extension SetNameVC: UITextFieldDelegate {
    
    func  textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case firstNameText:
            let (valid, message) = validate(firstNameText)
            if valid {
                self.nameNote.fadeOut()
                middleNameText.becomeFirstResponder()
            }
            if !valid {
                self.nameNote.fadeIn(message)
            }
        case middleNameText:
            let (valid, message) = validate(middleNameText)
            if valid {
                self.nameNote.fadeOut()
                lastNameText.becomeFirstResponder()
            }
            if !valid {
                self.nameNote.fadeIn(message)
            }
        case lastNameText:
            let (valid, message) = validate(lastNameText
            )
            if valid {
                self.nameNote.fadeOut()
                onContinueCLicked(continueButton)
            }
            if !valid {
                self.nameNote.fadeIn(message)
            }
        default:
            return false
        }
        return true
    }
    
    fileprivate func validate(_ textField: UITextField) -> (Bool, String?) {
        
        guard let text = textField.text else {
            return (false, nil)
        }
        
        switch textField {
        case firstNameText:
            return (text.count > 3, "Your first name is too short")
        case middleNameText:
            return (text.count > 3, "Your middle name is too short")
        case lastNameText:
            return (text.count > 3, "Your last name is too short")
        default:
            return (false, nil)
        }
    }
}
