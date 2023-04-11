//
//  MatchViewViewModel.swift
//  TinderClone
//
//  Created by Edwin Cardenas on 4/10/23.
//

import Foundation

struct MatchViewViewModel {

    private let currentUser: User
    let matchedUser: User

    let matchLabelText: String

    var currentUserImageURL: URL?
    var matchedUserImageURL: URL?

    init(currentUser: User, matchedUser: User) {
        self.currentUser = currentUser
        self.matchedUser = matchedUser

        matchLabelText = "You and \(matchedUser.name) have liked each other!"

        guard let currentUserImageString = currentUser.imageURLs.first,
              let matchedUserImageString = matchedUser.imageURLs.first else { return }
        
        currentUserImageURL = URL(string: currentUserImageString)
        matchedUserImageURL = URL(string: matchedUserImageString)
    }
}
