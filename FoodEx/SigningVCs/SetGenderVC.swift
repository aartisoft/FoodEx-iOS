//
//  GenderView.swift
//  FoodEx
//
//  Created by Ivan Taranov on 3/24/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation
import UIKit

class SetGenderVC : UIViewController {
    
    @IBOutlet weak var maleImage: UIImageView!
    @IBOutlet weak var femaleImage: UIImageView!
    @IBOutlet weak var continueButton: UIButton!
    var currentGender = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let tapGestureRecognizer0 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        let tapGestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        femaleImage.isUserInteractionEnabled = true
        maleImage.isUserInteractionEnabled = true
        femaleImage.addGestureRecognizer(tapGestureRecognizer0)
        maleImage.addGestureRecognizer(tapGestureRecognizer1)
        
        continueButton.isEnabled = false
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        continueButton.isEnabled = true
        
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        if tappedImage == maleImage {
            maleImage.image = UIImage(named: "male-enable")
            femaleImage.image = UIImage(named: "female-disable")
            currentGender = 0
        } else {
            maleImage.image = UIImage(named: "male-disable")
            femaleImage.image = UIImage(named: "female-enable")
            currentGender = 1
        }
    }
    
    
    @IBAction func onContinueClicked(_ sender: Any) {
        MyUserData.setNewGender(newGender: currentGender)
        
        UI.ShowPage(source: self, page: UI.Page.SetWeight)
    }
}
