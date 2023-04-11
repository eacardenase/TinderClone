//
//  Constants.swift
//  TinderClone
//
//  Created by Edwin Cardenas on 3/31/23.
//

import FirebaseFirestore

struct K {
    struct FStore {
        static let COLLECTION_USERS = Firestore.firestore().collection("users")
        static let COLLECTION_SWIPES = Firestore.firestore().collection("swipes")
        static let COLLECTION_MATCHES_MESSAGES = Firestore.firestore().collection("matches_messages")
    }
}
