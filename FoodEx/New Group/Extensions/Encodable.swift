//
//  Encodable.swift
//  FoodEx
//
//  Created by korsour on 4/5/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation

struct JSON {
    static let encoder = JSONEncoder()
}

extension Encodable {
    subscript(key: String) -> Any? {
        return dict[key]
    }
    
    var dict: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: JSON.encoder.encode(self))) as? [String: Any] ?? [:]
    }
}
