//
//  CardViewModel.swift
//  TinderClone
//
//  Created by Edwin Cardenas on 3/29/23.
//

import UIKit

class CardViewModel {
    
    private let user: User
    
    private var imageIndex = 0
    lazy var imageToShow = user.images.first
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
    
    func showNextPhoto() {
        guard imageIndex < user.images.count - 1 else { return }
        
        imageIndex += 1
        self.imageToShow = user.images[imageIndex]
    }
    
    func showPreviousPhoto() {
        guard imageIndex > 0 else { return }
        
        imageIndex -= 1
        self.imageToShow = user.images[imageIndex]
    }
}
