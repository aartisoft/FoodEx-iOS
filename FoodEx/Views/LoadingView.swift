//
//  LoadingView.swift
//  FoodEx
//
//  Created by korsour on 5/12/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import UIKit
import Foundation
import NVActivityIndicatorView

class LoadingView: UIView {
    static let kCONTENT_XIB_NAME = "LoadingView"
    static let identifier = "LoadingView"
    @IBOutlet weak var loader: NVActivityIndicatorView!
    @IBOutlet var contentView: UIView!
    
    static var currentLoadingView: LoadingView? = nil
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func commonInit(_ view: UIView) {
        Bundle.main.loadNibNamed(LoadingView.kCONTENT_XIB_NAME, owner: self, options: nil)
        contentView.frame = view.bounds
        contentView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        view.addSubview(contentView)
//        fixInView(viewController.view)
        //self.frame = contentView.superview!.frame

        loader.startAnimating()
    }
    
    static func show(view: UIView) {
        if LoadingView.currentLoadingView != nil {
            LoadingView.hide()
        }
        
        LoadingView.currentLoadingView = LoadingView(frame: CGRect())
        LoadingView.currentLoadingView!.commonInit(view)
    }
    
    static func hide() {
        currentLoadingView?.removeFromSuperview()
        LoadingView.currentLoadingView = nil
    }
}
