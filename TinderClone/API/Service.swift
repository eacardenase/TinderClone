//
//  Service.swift
//  TinderClone
//
//  Created by Edwin Cardenas on 3/30/23.
//

import UIKit
import FirebaseCore
import FirebaseStorage

struct Service {
    
    static func uploadImage(image: UIImage, completion: @escaping (String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.75) else {
            
            print("DEBUF: Could not get image data")
            
            return
        }
        let filename = NSUUID().uuidString
        let reference = Storage.storage().reference(withPath: "/images/\(filename)")
        
        reference.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("DEBUG: Error uploading image \(error.localizedDescription)")
                
                return
            }
            
            reference.downloadURL { url, error in
                if let error = error {
                    print("DEBUG: Error downloading image \(error.localizedDescription)")
                    
                    return
                }
                
                guard let imageURL = url?.absoluteString else { return }
                
                completion(imageURL)
            }
        }
    }
    
}
