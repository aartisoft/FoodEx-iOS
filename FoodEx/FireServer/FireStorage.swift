//
//  FireStorage.swift
//  FoodEx
//
//  Created by korsour on 5/21/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation
import Firebase

class FireStorage {
    
    static func uploadUserPhoto(photo: UIImage) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        let photoRef = storageRef.child("images/customers/" + Auth.auth().currentUser!.uid + "/photo.jpg")
        
        let data = photo.jpegData(compressionQuality: 0.9)
        
        let uploadTask = photoRef.putData(data!, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                return
            }
            // Metadata contains file metadata such as size, content-type.
            let size = metadata.size
            // You can also access to download URL after upload.
            photoRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    // Uh-oh, an error occurred!
                    return
                }
            }
        }
    }
}
