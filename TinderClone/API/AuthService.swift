//
//  AuthService.swift
//  TinderClone
//
//  Created by Edwin Cardenas on 3/30/23.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

struct AuthCredentials {
    let email: String
    let fullname: String
    let password: String
    let profileImage: UIImage
}

struct AuthService {
    
    static func logUserIn(withEmail email: String, password: String, completion: ((AuthDataResult?, Error?) -> Void)?) {
        
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
        
    }
    
    static func registerUser(withCredentials credentials: AuthCredentials, completion: ((Error?) -> Void)?) {
        
        Service.uploadImage(image: credentials.profileImage) { imageURL in
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { result, error in
                if let error = error {
                    print("DEBUG: Error signing user up \(error.localizedDescription)")
                    
                    return
                }
                
                guard let uid = result?.user.uid else {
                    print("TEST")
                    return }
                
                let data = [
                    "email": credentials.email,
                    "fullname": credentials.fullname,
                    "imageURL": imageURL,
                    "uid": uid,
                    "age": 19
                ] as [String: Any]
                
                K.FStore.COLLECTION_USER.document(uid).setData(data, completion: completion)
            }
        }
        
    }
}
