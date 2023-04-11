//
//  Service.swift
//  TinderClone
//
//  Created by Edwin Cardenas on 3/30/23.
//

import UIKit
import FirebaseAuth
import FirebaseStorage

struct Service {
    
    static func saveUserData(user: User, completion: @escaping (Error?) -> Void) {
        let data = [
            "uid": user.uid,
            "fullname": user.name,
            "email": user.email,
            "imageURLs": user.imageURLs,
            "age": user.age,
            "bio": user.bio,
            "profession": user.profession,
            "minSeekingAge": user.minSeekingAge,
            "maxSeekingAge": user.maxSeekingAge
        ] as [String : Any]
        
        K.FStore.COLLECTION_USERS.document(user.uid).setData(data, completion: completion)
    }
    
    static func fetchUser(withUid uid: String, completion: @escaping (User) -> Void) {
        K.FStore.COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            
            guard let userData = snapshot?.data() else { return }
            let user = User(dictionary: userData)
            
            completion(user)
        }
    }
    
    static func fetchUsers(forCurrentUser user: User, completion: @escaping ([User]) -> Void) {
        var users = [User]()
        
        let query = K.FStore.COLLECTION_USERS
            .whereField("age", isGreaterThanOrEqualTo: user.minSeekingAge)
            .whereField("age", isLessThanOrEqualTo: user.maxSeekingAge)
        
        fetchSwipes { swipedUserIDs in
            query.getDocuments { snapshot, error in
                snapshot?.documents.forEach({ document in
                    let user = User(dictionary: document.data())

                    guard user.uid != Auth.auth().currentUser?.uid else { return }
                    
                    // if not nil (not swiped before), append to users array
                    guard swipedUserIDs[user.uid] == nil else { return }
                    
                    users.append(user)
                })

                completion(users)
            }
        }
    }
    
    private static func fetchSwipes(completion: @escaping ([String: Bool]) -> Void ) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        K.FStore.COLLECTION_SWIPES.document(uid).getDocument { snapshot, error in
            guard let data = snapshot?.data() as? [String: Bool] else {
                completion([String: Bool]())
                
                return
            }
            
            completion(data)
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
    
    static func saveSwipe(forUser user: User, isLike: Bool, completion: ((Error?) -> Void)?) { // ((Error?) -> Void)? does not need escaping
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        K.FStore.COLLECTION_SWIPES.document(uid).getDocument { snapshot, error in
            
            if let error = error {
                print("DEBUG: Error saving swipe \(error.localizedDescription)")
                
                return
            }
            
            let data = [user.uid: isLike]
            
            if snapshot?.exists == true {
                K.FStore.COLLECTION_SWIPES.document(uid).updateData(data, completion: completion)
            } else {
                K.FStore.COLLECTION_SWIPES.document(uid).setData(data, completion: completion)
            }
        }
    }
    
    static func checkIfMatchExists(forUser user: User, completion: @escaping (Bool) -> Void) {
        guard let currentUserUid = Auth.auth().currentUser?.uid else { return }
        
        K.FStore.COLLECTION_SWIPES.document(user.uid).getDocument { snapshot, error in
            guard let data = snapshot?.data() else { return }
            guard let didMatch = data[currentUserUid] as? Bool else { return }
            
            completion(didMatch)
        }
    }
    
}
