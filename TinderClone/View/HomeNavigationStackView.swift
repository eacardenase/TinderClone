//
//  HomeNavigationStackView.swift
//  TinderClone
//
//  Created by Edwin Cardenas on 3/28/23.
//

import UIKit

protocol HomeNavigationStackViewDelegate: AnyObject {
    func showSettings()
    func showMessages()
}

class HomeNavigationStackView: UIStackView {
    // MARK: - Properties
    
    weak var delegate: HomeNavigationStackViewDelegate?
    
    let settingsButton = UIButton(type: .system)
    let tinderIcon = UIImageView(image: UIImage(named: "app_icon"))
    let messageButton = UIButton(type: .system)
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        settingsButton.setImage(UIImage(named: "top_left_profile")?.withRenderingMode(.alwaysOriginal), for: .normal)
        tinderIcon.contentMode = .scaleAspectFit
        messageButton.setImage(UIImage(named: "top_right_messages")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        [settingsButton, tinderIcon, messageButton].forEach { view in
            addArrangedSubview(view)
        }
        
        distribution = .equalCentering
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)
        
        settingsButton.addTarget(self, action: #selector(handleShowSettings), for: .touchUpInside)
        messageButton.addTarget(self, action: #selector(handleShowMessages), for: .touchUpInside)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Actions

extension HomeNavigationStackView {
    @objc private func handleShowSettings(_ sender: UIButton) {
        delegate?.showSettings()
    }
    
    @objc private func handleShowMessages(_ sender: UIButton) {
        delegate?.showMessages()
    }
}
