//
//  AuthButton.swift
//  TinderClone
//
//  Created by Edwin Cardenas on 3/29/23.
//

import UIKit

class AuthButton: UIButton {

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        configureUI()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AuthButton {
    private func configureUI() {
//        backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        backgroundColor = UIColor(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = 5
        isEnabled = false
    }
    
    private func layout() {
        heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
