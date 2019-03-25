//
//  Event.swift
//  dubsocial
//
//  Created by Ivan Taranov on 12/10/18.
//  Copyright © 2018 KorLab. All rights reserved.
//

import Foundation

class Event<T> {
    
    var lastData : T? = nil
    typealias EventHandler = (T) -> ()
    
    private var eventHandlers = [String: EventHandler]()
    
    func addHandler(uniqueName: String, handler: @escaping EventHandler) {
        eventHandlers[uniqueName] = handler
        if lastData != nil {
            handler(lastData!)
        }
    }
    
    func removeHandler(uniqueName: String) {
        eventHandlers = eventHandlers.filter {
            $0.key != uniqueName
        }
    }
    
    func raise(data: T) {
        for handler in eventHandlers {
            handler.value(data)
        }
        
        lastData = data
    }
}
