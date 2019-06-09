//
//  ChatVC.swift
//  FoodEx
//
//  Created by Ivan Taranov on 3/31/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation
import MessageKit
import MessageInputBar

/// A base class for the example controllers
final class ChatVC: ChatViewController {
    
    static var shared = ChatVC()
    
    override func configureMessageCollectionView() {
        super.configureMessageCollectionView()
        
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ChatVC.shared = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
//        if let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout {
//            layout.textMessageSizeCalculator.outgoingAvatarSize = .zero
//            layout.textMessageSizeCalculator.incomingAvatarSize = .zero
//        } to remove avatar pading
        
        initKeyboardManager()
        
        
        // TODO: refactor these mock messages
        let messages: [MessageText] = [
            MessageText(text: "newTextdasd", sentDate: Date(), messageId: UUID().uuidString, senderId: "asdasdasdasdasdasda", userType: 0, name: Name(first: "", middle: "", last: ""))]

        
        showMessages(messages: messages)

    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        messageInputBar.resignFirstResponder()
    }
    
    
    func showMessages(messages: [MessageText]) {
        var newMessages: [MockMessage] = []
        
        for var message in messages {
            newMessages.append(message.mockMessage)
        }
        
        
        self.messagesCollectionView.reloadData()
        self.messagesCollectionView.scrollToBottom()
        
        for var message in messages {
            insertMessage(message.mockMessage)
        }
        //            insertMessage(message.mockMessage)
    }
}

// MARK: - MessagesDisplayDelegate

extension ChatVC: MessagesDisplayDelegate {
//    func currentSender() -> SenderType {
//        let a = NSObject()
//        return a as! SenderType // korsour костыль
//    }
    
    // MARK: - Text Messages
    
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .white : .darkText
    }
    
    func detectorAttributes(for detector: DetectorType, and message: MessageType, at indexPath: IndexPath) -> [NSAttributedString.Key: Any] {
        return MessageLabel.defaultAttributes
    }
    
    func enabledDetectors(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> [DetectorType] {
        return [.url, .address, .phoneNumber, .date, .transitInformation]
    }
    
    // MARK: - All Messages
    
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? UIColor.primary : UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
    }
    
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        
//        let tail: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight : .bottomLeft // korsour
        return .bubble
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        let avatar = Avatar(image: nil, initials: "ME")
        avatarView.set(avatar: avatar) // korsour
        
//         avatarView.isHidden = true
    }
}

// MARK: - MessagesLayoutDelegate

extension ChatVC: MessagesLayoutDelegate {
    
//    func cellTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
//        return 18
//    }
//
    func cellBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 0
    }
    
//    func messageTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
//        return 20
//    }
    
    func messageBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 14
    }
    
}

extension ChatVC {
    
    func initKeyboardManager() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    
//    @objc func dismissKeyboardKor (_ sender: UITapGestureRecognizer) {
//         resignFirstResponder()
//    }
}
