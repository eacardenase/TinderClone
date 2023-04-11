//
//  SettingsHeaderViewModel.swift
//  TinderClone
//
//  Created by Edwin Cardenas on 4/10/23.
//

import Foundation

struct SettingsHeaderViewModel {
    
    private let user: User
    
    var imageURLs = [URL?]()
    
    init(user: User) {
        self.user = user
        
        imageURLs = user.imageURLs.map({ URL(string: $0) })
    }
    
}
