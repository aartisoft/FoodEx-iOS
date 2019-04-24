//
//  UIVIewControllerKeyboard.swift
//  FoodEx
//
//  Created by Ivan Taranov on 3/22/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation
import  UIKit

class KeyboardVC : UIViewController {
    
    var viewsToDismissKeyboard: [UIView] = []
    var viewsToMove: [UIView: CGFloat] = [:]
    var isKeyboardShowed: Bool = false
    var latestKeyBoardHeight: CGFloat = 0
    var isKeyboardShown: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if isKeyboardShown {
            return
        }
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            latestKeyBoardHeight = keyboardSize.height
            for (view, offset) in viewsToMove {
                view.frame.origin.y -= latestKeyBoardHeight * offset
            }
        }
        isKeyboardShown = true
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if !isKeyboardShown {
            return
        }
        
        for (view, offset) in viewsToMove {
            view.frame.origin.y += latestKeyBoardHeight * offset
        }
        isKeyboardShown = false
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        for view in viewsToDismissKeyboard {
            view.resignFirstResponder()
        }
    }
}
