//
//  CustomTextField.swift
//  TinderClone
//
//  Created by Edwin Cardenas on 3/29/23.
//

import UIKit

class CustomTextField: UITextField {
    
    private let placeholderText: String
    private let isSecure: Bool
    
    init(placeholderText: String, isSecure: Bool = false) {
        self.placeholderText = placeholderText
        self.isSecure = isSecure
        
        super.init(frame: .zero)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomTextField {
    private func configureUI() {
        let spacer = UIView()
        
        spacer.setDimensions(height: 50, width: 12)
        leftView = spacer
        leftViewMode = .always
        rightView = spacer
        rightViewMode = .always
        
        keyboardAppearance = .dark
        
        borderStyle = .none
        textColor = .white
        backgroundColor = UIColor(white: 1, alpha: 0.2)
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        layer.cornerRadius = 5
        isSecureTextEntry = isSecure
        attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [
            NSAttributedString.Key.foregroundColor: UIColor(white: 1, alpha: 0.7)
        ])
    }
}
