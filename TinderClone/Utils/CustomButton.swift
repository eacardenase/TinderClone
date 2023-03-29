//
//  CustomButton.swift
//  TinderClone
//
//  Created by Edwin Cardenas on 3/29/23.
//

import UIKit

class CustomButton: UIButton {
    
    private let title: String
    private let subtitle: String
    private let type: ButtonType
    
    init(title: String, subtitle: String, type: ButtonType) {
        
        self.title = title
        self.subtitle = subtitle
        self.type = type
        
        super.init(frame: .zero)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomButton {
    private func configureUI() {
        let attributedTitle = NSMutableAttributedString(string: "\(title)  ", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ])
        
        attributedTitle.append(NSAttributedString(string: subtitle, attributes: [
            .foregroundColor: UIColor.white,
            .font: UIFont.boldSystemFont(ofSize: 16)
        ]))
        
        setAttributedTitle(attributedTitle, for: .normal)
    }
}
