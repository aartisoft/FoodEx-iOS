//
//  PromoCard.swift
//  FoodEx
//
//  Created by korsour on 4/28/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation
import UIKit

class PromoCard: UICollectionViewCell {
    static let kCONTENT_XIB_NAME = "PromoCard"
    @IBOutlet weak var image: UIImageView!
    static let identifier = "PromoCard"
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var actionButton: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var panel: UIView!
    @IBOutlet weak var contentViewKor: UIView!
    
    var _promo: Promo? = nil
    var promo: Promo? {
        get {
            return _promo
        }
        set {
            _promo = newValue
            
            image.image = promo!.image
            titleLabel.text = promo!.title
            dateLabel.text = promo!.date
        }
    }
    //
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        commonInit()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        commonInit()
//    }
//
    
    
    
    func initPromo(promo: Promo) {
        commonInit()
        
        self.promo = promo
        
        commonInit()
    }
    
    func commonInit() {
        
        
        
        contentViewKor.layer.cornerRadius = 15
        contentViewKor.layer.borderWidth = 1.0
        contentViewKor.layer.borderColor = UIColor.clear.cgColor
        contentViewKor.layer.masksToBounds = false

        self.panel.layer.cornerRadius = 15
        self.image.layer.cornerRadius = 15

        contentViewKor.layer.shadowColor = UIColor.black.cgColor
        contentViewKor.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        contentViewKor.layer.shadowRadius = 5.0
        contentViewKor.layer.shadowOpacity = 0.8
        contentViewKor.layer.masksToBounds = false
        contentViewKor.layer.shadowPath = UIBezierPath(roundedRect: contentViewKor.bounds, cornerRadius: contentViewKor.layer.cornerRadius).cgPath
    }
    
        
        
//        contentView.layer.cornerRadius = 8
//        contentView.layer.masksToBounds = true
//        contentView.layer.shadowColor = UIColor.gray.cgColor
//        contentView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
//        contentView.layer.shadowRadius = 7.0
//        contentView.layer.shadowOpacity = 0.4
//        contentView.layer.masksToBounds = false
}
