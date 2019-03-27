//
//  PausePlanVC.swift
//  FoodEx
//
//  Created by Ivan Taranov on 3/27/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation
import UIKit
import XLPagerTabStrip

class PausePlanVC: UIViewController, IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Pause Plan")
    }
}
