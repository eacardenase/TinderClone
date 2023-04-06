//
//  SettingsFooter.swift
//  TinderClone
//
//  Created by Edwin Cardenas on 4/5/23.
//

import UIKit

protocol SettingsFooterDelegate: AnyObject {
    func handleLogout()
}

class SettingsFooter: UIView {
    
    // MARK: - Properties
    
    weak var delegate: SettingsFooterDelegate?
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers

extension SettingsFooter {
    private func configureUI() {
        
        let spacer = UIView()
        spacer.backgroundColor = .systemGroupedBackground
        spacer.setDimensions(height: 32, width: frame.width)
        
        spacer.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(spacer)
        addSubview(logoutButton)
        
        // logoutButton
        NSLayoutConstraint.activate([
            logoutButton.topAnchor.constraint(equalTo: spacer.bottomAnchor),
            logoutButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            logoutButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            logoutButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

// MARK: - Actions

extension SettingsFooter {
    @objc private func handleLogout(_ sender: UIButton) {
        delegate?.handleLogout()
    }
}
