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

class HomeTabsVC: SegmentedPagerTabStripViewController {
    
    var presentedViewControllers: [UIViewController] = []
    //@IBOutlet var segmentedControl: UISegmentedControl!
    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        // change segmented style
//        settings.style.segmentedControlColor = .white
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settings.style.segmentedControlColor = UIColor.red
        
        navigationController?.pushViewController(ChatVC(), animated: true)
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let stb = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        presentedViewControllers.append(stb.instantiateViewController(withIdentifier : "DashboardVC"))
//        presentedViewControllers.append(stb.instantiateViewController(withIdentifier : "HistoryVC"))
        presentedViewControllers.append(stb.instantiateViewController(withIdentifier : "CalendarVC"))
        
        return presentedViewControllers
    }
}
