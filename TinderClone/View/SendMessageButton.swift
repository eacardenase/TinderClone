//
//  SendMessageButton.swift
//  TinderClone
//
//  Created by Edwin Cardenas on 4/10/23.
//

import UIKit

class SendMessageButton: UIButton {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
//        let leftColor = UIColor(red: 0.99, green: 0.36, blue: 0.37, alpha: 1.00)
        let leftColor = UIColor(red: 1, green: 0.01176470588, blue: 0.4470588235, alpha: 1.00)
//        let rightColor = UIColor(red: 0.90, green: 0.00, blue: 0.45, alpha: 1.00)
        let rightColor = UIColor(red: 1, green: 0.3921568627, blue: 0.3176470588, alpha: 1.00)
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = rect
        gradientLayer.colors = [leftColor.cgColor, rightColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        
        self.layer.insertSublayer(gradientLayer, at: 0)
        
        layer.cornerRadius = rect.height / 2
        clipsToBounds = true
    }
}
