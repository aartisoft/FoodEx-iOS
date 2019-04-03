//
//  AlertsManager.swift
//  dubsocial
//
//  Created by Ivan Taranov on 12/24/18.
//  Copyright © 2018 KorLab. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class AlertsManager {
    
    static var loadingScreens = [String : NVActivityIndicatorView]()
    
    static func showDialogue(view: UIViewController, title: String, message: String, confirmButtonText: String, cancelButtonText: String, onConfirm: @escaping () -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: confirmButtonText, style: .destructive) { (_) in
            onConfirm()
        }
        
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: cancelButtonText, style: .cancel) { (_) in }
        
//        //adding textfields to our dialog box
//        alertController.addTextField { (textField) in
//            textField.placeholder = "Enter Name"
//        }
//        alertController.addTextField { (textField) in
//            textField.placeholder = "Enter Email"
//        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        view.present(alertController, animated: true, completion: nil)
    }
    
    static func showAlert(view: UIViewController, title: String, message: String, confirmButtonText: String, onConfirm: @escaping () -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: confirmButtonText, style: .destructive) { (_) in
            onConfirm()
        }
        
        alertController.addAction(confirmAction)
        
        view.present(alertController, animated: true, completion: nil)
    }
    
    static func showLoading(view: UIView, frame: CGRect, uniqueName: String) {
        loadingScreens[uniqueName] = NVActivityIndicatorView(frame: frame, type: NVActivityIndicatorType.ballRotateChase, color: UIColor.red, padding: NVActivityIndicatorView.DEFAULT_PADDING)
        loadingScreens[uniqueName]!.startAnimating()
        view.addSubview(loadingScreens[uniqueName]!)
    }
    
    static func hideLoading(uniqueName: String) {
        loadingScreens[uniqueName]!.stopAnimating()
        loadingScreens.removeValue(forKey: uniqueName)
    }
}
