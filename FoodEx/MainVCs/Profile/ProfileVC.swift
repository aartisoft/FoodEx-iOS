//
//  ProfileVC.swift
//  FoodEx
//
//  Created by Ivan Taranov on 3/26/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation
import UIKit

class ProfileVC : UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    static var shared: ProfileVC? = nil
    
    @IBAction func showRatingWindow(_ sender: Any) {
        UI.showPopUp(source: self, popUp: .ManagerRating)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProfileVC.shared = self
        
        self.navigationController?.isNavigationBarHidden = true
        
        Manager.shared.phone = PhoneNumber(phoneValid: "380677284513")
        
        if let name = UserData.my.name {
            nameLabel.text = name.first + " " + name.last
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
