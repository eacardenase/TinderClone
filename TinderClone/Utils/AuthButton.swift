//
//  AuthButton.swift
//  TinderClone
//
//  Created by Edwin Cardenas on 3/29/23.
//

import UIKit

class AuthButton: UIButton {
    
    private let title: String
    private let type: ButtonType
    
    init(title: String, type: ButtonType) {
        
        self.title = title
        self.type = type
        
        super.init(frame: .zero)
        
        configureUI()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AuthButton {
    private func configureUI() {
        setTitle(title, for: .normal)
//        backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        backgroundColor = UIColor(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        layer.cornerRadius = 5
        isEnabled = false
    }
    
    private func layout() {
        heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
