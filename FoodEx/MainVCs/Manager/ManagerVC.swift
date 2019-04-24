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
        UI.showPopUp(source: self, popUp: .Rating)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        Manager.shared.phone = PhoneNumber(phoneValid: "380677284513")
        print(Manager.shared.phone.phoneValid)
        phoneLabel.setTitle(Manager.shared.phone.phoneFormatted, for: .normal)
        print(Manager.shared.phone.phoneFormatted)
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
}
