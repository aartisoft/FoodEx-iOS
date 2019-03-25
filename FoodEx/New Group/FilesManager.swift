//
//  File.swift
//  dubsocial
//
//  Created by Ivan Taranov on 12/15/18.
//  Copyright © 2018 KorLab. All rights reserved.
//

import Foundation

class FilesManager {
    
    private static var instance: FilesManager? = nil
    static func Instance() -> FilesManager {
        if instance == nil {
            instance = FilesManager()
        }
        return instance!
    }
    
    func getFullPath(relativePath: String) -> URL {
        return URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(relativePath)
    }
}
