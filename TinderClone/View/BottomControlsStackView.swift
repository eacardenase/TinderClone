//
//  BottomControlsStackView.swift
//  TinderClone
//
//  Created by Edwin Cardenas on 3/28/23.
//

import UIKit

protocol BottomControllerStackViewDelegate: AnyObject {
    func handleLike()
    func handleDislike()
    func handleRefresh()
}

class BottomControlsStackView: UIStackView {
    
    // MARK: - Properties
    
    weak var delegate: BottomControllerStackViewDelegate?
    
    let refreshButton = UIButton()
    let dislikeButton = UIButton()
    let superLikeButton = UIButton()
    let likeButton = UIButton()
    let boostButton = UIButton()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers

extension BottomControlsStackView {
    func configureUI() {
        distribution = .fillEqually // or .equalCentering

        heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        refreshButton.setImage(UIImage(named: "refresh_circle")?.withRenderingMode(.alwaysOriginal), for: .normal)
        dislikeButton.setImage(UIImage(named: "dismiss_circle")?.withRenderingMode(.alwaysOriginal), for: .normal)
        superLikeButton.setImage(UIImage(named: "super_like_circle")?.withRenderingMode(.alwaysOriginal), for: .normal)
        likeButton.setImage(UIImage(named: "like_circle")?.withRenderingMode(.alwaysOriginal), for: .normal)
        boostButton.setImage(UIImage(named: "boost_circle")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        [refreshButton, dislikeButton, superLikeButton, likeButton, boostButton].forEach { view in
            addArrangedSubview(view)
        }
        
        refreshButton.addTarget(self, action: #selector(handleRefresh), for: .touchUpInside)
        dislikeButton.addTarget(self, action: #selector(handleDislike), for: .touchUpInside)
        likeButton.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
    }
}

// MARK: - Actions

extension BottomControlsStackView {
    @objc func handleRefresh(_ sender: UIButton) {
        delegate?.handleRefresh()
    }
    
    @objc func handleLike(_ sender: UIButton) {
        delegate?.handleLike()
    }
    
    @objc func handleDislike(_ sender: UIButton) {
        delegate?.handleDislike()
    }
}
