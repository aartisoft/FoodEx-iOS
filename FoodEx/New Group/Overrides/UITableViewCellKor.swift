//
//  UITableViewCellKor.swift
//  FoodEx
//
//  Created by korsour on 4/6/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation
import UIKit

class UITableViewCellKor : UITableViewCell {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView?.frame = CGRect(x: 30, y: 10, width: 24, height: 24)
        
        self.preservesSuperviewLayoutMargins = false
        self.separatorInset = UIEdgeInsets.zero
        self.layoutMargins = UIEdgeInsets.zero
    }

}
