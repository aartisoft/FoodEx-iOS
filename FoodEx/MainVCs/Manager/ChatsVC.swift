//
//  ChatsVC.swift
//  FoodEx
//
//  Created by korsour on 09.06.2019.
//  Copyright © 2019 KorLab. All rights reserved.
//

import UIKit

class ChatsVC: UITableViewController {
    
    static var shared = UITableViewController()
    
    @IBOutlet var chatsTable: UITableView!
    private var chatsList: [Chat] = []
//
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ChatsVC.shared = self
        
        chatsTable.tableFooterView = UIView()
        
        self.title = "Chats"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "New", style: .done, target: self, action: #selector(self.createNewTapped(sender:)))
        
        getChatsList()
    }
//
    func getChatsList() {

        for var i in 0...1 {
            let chat = Chat(title: "title" + String(i), startTime: Date(), customerId: "dsda", supportId: "asdas")
            self.chatsTable.beginUpdates()
            self.chatsList.insert(chat, at: 0)
            self.chatsTable.insertRows(at: [IndexPath.init(row: 0, section: 0)], with: .automatic)
            self.chatsTable.endUpdates()
        }
    }
    
    @objc func createNewTapped(sender: UIBarButtonItem) {
        UI.showPopUp(source: self, popUp: .CreatingChat)
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return chatsList.count
    }

    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Ask for a cell of the appropriate type.
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath) as! ChatCell
        
        // Configure the cell’s contents with the row and section number.
        // The Basic cell style guarantees a label view is present in textLabel.
        cell.title.text = chatsList[indexPath.row].title
        return cell
    }
}
