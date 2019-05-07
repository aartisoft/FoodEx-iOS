//
//  UITableViewCellKor.swift
//  FoodEx
//
//  Created by korsour on 4/6/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class UITableViewCellKor : UITableViewCell {
    
    @IBInspectable var actionCode: String = ""
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView?.frame = CGRect(x: 30, y: 10, width: 24, height: 24)
        
        self.preservesSuperviewLayoutMargins = false
        self.separatorInset = UIEdgeInsets.zero
        self.layoutMargins = UIEdgeInsets.zero
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.someAction (_:)))
        self.addGestureRecognizer(gesture)
        
    }

    
    @objc func someAction(_ sender:UITapGestureRecognizer){
        switch actionCode {
        case "discount": break
            
        case "friends":
            
            break
        case "feedback":
            break
        case "blog":
            break
        case "settings":
            UI.showPage(source: ProfileVC.shared!, page: .Settings)
            break
        case "exit":
            break
        default:
            return
        }
        
    }
}
