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
    
    static func fetchUser(withUid uid: String, completion: @escaping (User) -> Void) {
        K.FStore.COLLECTION_USER.document(uid).getDocument { snapshot, error in
            
            guard let userData = snapshot?.data() else { return }
            let user = User(dictionary: userData)
            
            completion(user)
        }
    }
    
    static func fetchUsers(completion: @escaping ([User]) -> Void) {
        var users = [User]()
        
        K.FStore.COLLECTION_USER.getDocuments { snapshot, error in
            snapshot?.documents.forEach({ document in
                let user = User(dictionary: document.data())
                
                users.append(user)
            })
            
            completion(users)
        }
    }
    
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
