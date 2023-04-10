//
//  KeepSwipingButton.swift
//  TinderClone
//
//  Created by Edwin Cardenas on 4/10/23.
//

import UIKit

class KeepSwipingButton: UIButton {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let leftColor = UIColor(red: 1, green: 0.01176470588, blue: 0.4470588235, alpha: 1.00)
        let rightColor = UIColor(red: 1, green: 0.3921568627, blue: 0.3176470588, alpha: 1.00)
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [leftColor.cgColor, rightColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        
        let cornerRadius = rect.height / 2
        let maskLayer = CAShapeLayer()
        let maskPath = CGMutablePath()
        
        maskPath.addPath(UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).cgPath)
        
        // removes middle portion of the button
        maskPath.addPath(UIBezierPath(roundedRect: rect.insetBy(dx: 2, dy: 2), cornerRadius: cornerRadius).cgPath)
        
        maskLayer.path = maskPath
        maskLayer.fillRule = .evenOdd
        
        gradientLayer.mask = maskLayer
        
        self.layer.insertSublayer(gradientLayer, at: 0)
        
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
        
        gradientLayer.frame = rect
    }
}
