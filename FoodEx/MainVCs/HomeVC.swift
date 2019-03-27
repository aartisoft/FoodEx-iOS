//
//  MainVC.swift
//  FoodEx
//
//  Created by Ivan Taranov on 3/25/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation
import UIKit
import XLPagerTabStrip

class HomeTabsVC: ButtonBarPagerTabStripViewController, IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "My Child title")
    }
    
    
    var presentedViewControllers: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let stb = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        //.presentedViewControllers.append(self)
        presentedViewControllers.append(stb.instantiateViewController(withIdentifier : "DailyPlanVC"))
        presentedViewControllers.append(stb.instantiateViewController(withIdentifier : "PausePlanVC"))
        
        return presentedViewControllers
    }
}
