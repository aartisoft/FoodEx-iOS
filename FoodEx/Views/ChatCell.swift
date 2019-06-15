//
//  ChatCell.swift
//  FoodEx
//
//  Created by korsour on 09.06.2019.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation
import UIKit
import Firebase

@IBDesignable class ChatCell : UITableViewCell {
    
    // TODO: refactor it
    @IBInspectable var chatId: String = ""
    @IBOutlet weak var chatImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var time: UILabel!
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        self.imageView?.frame = CGRect(x: 30, y: 10, width: 24, height: 24)
//        
//        self.preservesSuperviewLayoutMargins = false
//        self.separatorInset = UIEdgeInsets.zero
//        self.layoutMargins = UIEdgeInsets.zero
//        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.someAction (_:)))
        self.addGestureRecognizer(gesture)
    }
    
    
    func initializeChat(chatId: String) {
        self.chatId = chatId
    }
    
    
    @objc func someAction(_ sender:UITapGestureRecognizer){
        UI.showPage(source: ChatsVC.shared, page: .Chat)
        ChatVC.initChatHistory(chatId: chatId)
    }
}
