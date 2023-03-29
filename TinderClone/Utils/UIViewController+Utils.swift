//
//  UIViewController+Utils.swift
//  TinderClone
//
//  Created by Edwin Cardenas on 3/29/23.
//

import UIKit

extension UIViewController {
    func configureGradientLayer() {
        let topColor = UIColor(red: 0.99, green: 0.36, blue: 0.37, alpha: 1.00)
        let bottomColor = UIColor(red: 0.90, green: 0.00, blue: 0.45, alpha: 1.00)
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0, 1]
        view.layer.addSublayer(gradientLayer)
        gradientLayer.frame = view.frame
    }
}
