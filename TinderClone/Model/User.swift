//
//  User.swift
//  TinderClone
//
//  Created by Edwin Cardenas on 3/29/23.
//

import UIKit

struct User {
    var name: String
    var profession: String
    var age: Int
    var bio: String
    var email: String
    let uid: String
    let profileImageURL: String
    var minSeekingAge: Int
    var maxSeekingAge: Int
    
    init(dictionary: [String: Any]) {
        self.name = dictionary["fullname"] as? String ?? ""
        self.profession = dictionary["profession"] as? String ?? ""
        self.age = dictionary["age"] as? Int ?? 0
        self.bio = dictionary["bio"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.profileImageURL = dictionary["imageURL"] as? String ?? ""
        self.minSeekingAge = dictionary["minSeekingAge"] as? Int ?? 18
        self.maxSeekingAge = dictionary["maxSeekingAge"] as? Int ?? 40
    }
}
