//
//  CardViewModel.swift
//  TinderClone
//
//  Created by Edwin Cardenas on 3/29/23.
//

import UIKit

class CardViewModel {
    
    let user: User
    let userInfoText: NSAttributedString
    
    var imageURL: URL?
    let imageURLs: [String]
    
    private var imageIndex = 0
    var index: Int {
        imageIndex
    }
    
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
        self.imageURLs = user.imageURLs
        self.imageURL = URL(string: user.imageURLs[0])
    }
    
    func showNextPhoto() {
        guard imageIndex < imageURLs.count - 1 else { return }

        imageIndex += 1
        imageURL = URL(string: imageURLs[imageIndex])
    }
    
    func showPreviousPhoto() {
        guard imageIndex > 0 else { return }
        
        imageIndex -= 1
        imageURL = URL(string: imageURLs[imageIndex])
    }
}
