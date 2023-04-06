//
//  SegmentedBarView.swift
//  TinderClone
//
//  Created by Edwin Cardenas on 4/6/23.
//

import UIKit

class SegmentedBarView: UIStackView {
    
    private let numberOfSegments: Int
    
    init(numberOfSegments: Int) {
        self.numberOfSegments = numberOfSegments
        
        super.init(frame: .zero)
        
        setupViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers

extension SegmentedBarView {
    private func setupViews() {
        for _ in (0..<numberOfSegments) {
            let barView = UIView()
            
            barView.backgroundColor = UIColor.barDeselectedColor
            
            addArrangedSubview(barView)
            
            arrangedSubviews.first?.backgroundColor = .white
            spacing = 4
            distribution = .fillEqually
        }
    }
    
    func setHighlightedBar(_ index: Int) {
        arrangedSubviews.forEach({ $0.backgroundColor = .barDeselectedColor })
        arrangedSubviews[index].backgroundColor = .white
    }
}

