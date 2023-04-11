//
//  MatchCellViewModel.swift
//  TinderClone
//
//  Created by Edwin Cardenas on 4/11/23.
//

import Foundation

struct MatchCellViewModel {
    
    let nameText: String
    let profileImageURL: URL?
    let uid: String
    
    init(match: Match) {
        nameText = match.name
        profileImageURL = URL(string: match.profileImageURL)
        uid = match.uid
    }
    
}
