//
//  CreatingChatVC.swift
//  FoodEx
//
//  Created by korsour on 09.06.2019.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation
import UIKit

class CreatingChatVC : KeyboardVC, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var messageText: UITextView!
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var titleText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        
        viewsToMove[popUpView] = 0.5
        viewsToDismissKeyboard.append(titleText)
        viewsToDismissKeyboard.append(messageText)
        
        HomeTabsVC.shared!.tabBarController!.tabBar.isHidden = true
    }
    
    @IBAction func cancelCreating(_ sender: Any) {
        UI.hideCurrentPopUp()
        
        HomeTabsVC.shared!.tabBarController!.tabBar.isHidden = false
    }
    
    
    @IBAction func createChat(_ sender: Any) {
        let newChat = [
            "title": titleText.text,
            "message": MessageText(text: messageText.text).dict,
            ] as [String : Any]
        
        LoadingView.show(view: self.view)
        
        FireFunctions.callFunction(.createNewChatSession, newChat, callback: { (dictResponse) in
            LoadingView.hide()
            self.cancelCreating(self)
        })
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        
        return numberOfChars <= 200
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        return updatedText.count <= 50
    }
}

