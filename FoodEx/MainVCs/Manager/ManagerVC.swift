//
//  ManagerVC.swift
//  FoodEx
//
//  Created by korsour on 4/17/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation
import UIKit

class ManagerVC : UIViewController {
    
    @IBOutlet weak var phoneLabel: UIButton!
    
    @IBAction func showRatingWindow(_ sender: Any) {
        UI.showPopUp(source: self, popUp: .ManagerRating)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        Manager.shared.phone = PhoneNumber(phoneValid: "380677284513")
        phoneLabel.setTitle(Manager.shared.phone.phoneFormatted, for: .normal)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    @IBAction func callManagerPhone(_ sender: Any) {
        guard let number = URL(string: "tel://" + Manager.shared.phone.phoneValid) else { return }
        UIApplication.shared.open(number, options: [:], completionHandler: nil)
    }
    
    
    @IBAction func askManagerToRecall(_ sender: Any) {
        let alert = UIAlertController(title: "New request", message: "Do you want our manager to recall you?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.destructive, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: {(event) in
            let alert = UIAlertController(title: "New request", message: "Request 'Ask manager to recall' has been submited. She will recall you as soon, as possible.", preferredStyle: UIAlertController.Style.alert)
            // TODO: add sending request to the server
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func askCourierToRecall(_ sender: Any) {
        let alert = UIAlertController(title: "New request", message: "Do you want our courier to recall you?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.destructive, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: {(event) in
            let alert = UIAlertController(title: "New request", message: "Request 'Ask courier to recall' has been submited. She will recall you as soon, as possible.", preferredStyle: UIAlertController.Style.alert)
            // TODO: add sending request to the server
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func changeCurrentPlan(_ sender: Any) {
        let alert = UIAlertController(title: "New request", message: "Do you want to change the current plan?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.destructive, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: {(event) in
            let alert = UIAlertController(title: "New request", message: "Your request to change your current plan has been submited. Our managers will call you soon.", preferredStyle: UIAlertController.Style.alert)
            // TODO: add sending request to the server
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func postponeDelivery(_ sender: Any) {
        let alert = UIAlertController(title: "New request", message: "Do you want to postpone the delivery?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.destructive, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: {(event) in
            let alert = UIAlertController(title: "New request", message: "Your request to postpone the delivery has been submited. Our courier will call you soon.", preferredStyle: UIAlertController.Style.alert)
            // TODO: add sending request to the server
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func changeDeliveryLocation(_ sender: Any) {
        let alert = UIAlertController(title: "New request", message: "Do you want to change the delivery location?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.destructive, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: {(event) in
            let alert = UIAlertController(title: "New request", message: "Your request to change the location of the delivery has been submited. Our courier will call you soon.", preferredStyle: UIAlertController.Style.alert)
            // TODO: add sending request to the server
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func cancelDelivery(_ sender: Any) {
        let alert = UIAlertController(title: "New request", message: "Do you want to cancel the delivery?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.destructive, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: {(event) in
            let alert = UIAlertController(title: "New request", message: "Your request to cancel the delivery has been submited. Our manager will call you soon.", preferredStyle: UIAlertController.Style.alert)
            // TODO: add sending request to the server
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
