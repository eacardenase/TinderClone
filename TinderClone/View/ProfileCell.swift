//
//  ProfileCell.swift
//  TinderClone
//
//  Created by Edwin Cardenas on 4/6/23.
//

import UIKit

class ProfileCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "ProfileCell"
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
