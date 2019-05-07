//
//  SetingsVC.swift
//  FoodEx
//
//  Created by korsour on 5/3/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import UIKit

class SettingsVC: KeyboardVC {

    @IBOutlet weak var packageButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        
        
        let textFields = getAllTextFields(fromView: contentView)
        textFields.forEach({viewsToDismissKeyboard.append($0)})
        
    }
    
    @objc func back(sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }

    
    @IBAction func onChangePackClicked(_ sender: Any) {
        let alert = UIAlertController(title: "Which is more convinient for you?", message: "Choose one of types of the delivery package.", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Package", style: .default, handler: {(alert: UIAlertAction!) in
            self.packageButton.titleLabel?.text = "Package"}))
        alert.addAction(UIAlertAction(title: "Bag", style: .default, handler: {(alert: UIAlertAction!) in
            self.packageButton.titleLabel?.text = "Bag"}))
        alert.addAction(UIAlertAction(title: "Cart", style: .default, handler: {(alert: UIAlertAction!) in
            self.packageButton.titleLabel?.text = "Cart"}))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    func getAllTextFields(fromView view: UIView)-> [UITextField] {
        return view.subviews.flatMap { (view) -> [UITextField]? in
            if view is UITextField {
                return [(view as! UITextField)]
            } else {
                return getAllTextFields(fromView: view)
            }
            }.flatMap({$0})
    }
}
