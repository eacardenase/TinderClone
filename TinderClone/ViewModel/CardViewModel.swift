//
//  CardViewModel.swift
//  TinderClone
//
//  Created by Edwin Cardenas on 3/29/23.
//

import UIKit

struct CardViewModel {
    
    let user: User
    
    let userInfoText: NSAttributedString
    
    init(user: User) {
        self.user = user
        
        let attributedText = NSMutableAttributedString(string: user.name, attributes: [
            .font: UIFont.systemFont(ofSize: 32, weight: .heavy),
            .foregroundColor: UIColor.white
        ])
        
        attributedText.append(NSAttributedString(string: "  \(user.age)", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]))
        
        self.userInfoText = attributedText
    }
}
