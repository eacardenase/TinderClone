//
//  BottomControlsStackView.swift
//  TinderClone
//
//  Created by Edwin Cardenas on 3/28/23.
//

import UIKit

class BottomControlsStackView: UIStackView {
    
    // MARK: - Properties
    
    let refreshButton = UIButton()
    let dislikeButton = UIButton()
    let superLikeButton = UIButton()
    let likeButton = UIButton()
    let boostButton = UIButton()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
