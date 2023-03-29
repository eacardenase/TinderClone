//
//  CardView.swift
//  TinderClone
//
//  Created by Edwin Cardenas on 3/28/23.
//

import UIKit

enum SwipeDirection: Int {
    case left = -1
    case right = 1
}

class CardView: UIView {
    
    // MARK: - Properties
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "jane1")
        
        return imageView
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "Jane Doe", attributes: [
            .font: UIFont.systemFont(ofSize: 32, weight: .heavy),
            .foregroundColor: UIColor.white
        ])
        
        attributedText.append(NSAttributedString(string: "  18", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]))
        
        label.attributedText = attributedText
        
        return label
    }()
    
    private lazy var infoButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "info_icon")?.withRenderingMode(.alwaysOriginal), for: .normal) // .alwaysOriginal prevents the image to turn sligthly blue
        
        return button
    }()
    
    private let gradientLayer = CAGradientLayer()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemPurple
        layer.cornerRadius = 10
        clipsToBounds = true
        
        configureGestureRecognizers()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // get's called after the view have finished laying every subview
    override func layoutSubviews() {
        gradientLayer.frame = self.frame
    }
}

// MARK: - Helpers

extension CardView {
    func setupViews() {
        addSubview(imageView)
        
        configureGradient()
        
        addSubview(infoLabel)
        addSubview(infoButton)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoButton.translatesAutoresizingMaskIntoConstraints = false
        
        // imageView
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        // infoLabel
        NSLayoutConstraint.activate([
            infoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            infoLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            infoLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
        
        // infoButton
        NSLayoutConstraint.activate([
            infoButton.centerYAnchor.constraint(equalTo: infoLabel.centerYAnchor),
            infoButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            infoButton.heightAnchor.constraint(equalToConstant: 40),
            infoButton.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configureGradient() {
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5, 1.1]
        layer.addSublayer(gradientLayer)
    }
    
    func configureGestureRecognizers() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleChangePhoto))
        
        addGestureRecognizer(pan)
        addGestureRecognizer(tap)
    }
    
    func panCard(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: nil)
        let degrees: CGFloat = translation.x / 20
        let angle = degrees * .pi / 180
        let rotationalTransform = CGAffineTransform(rotationAngle: angle)
        
        self.transform = rotationalTransform.translatedBy(x: translation.x, y: translation.y)
    }
    
    func resetCardPosition(_ sender: UIPanGestureRecognizer) {
        
        let direction: SwipeDirection = sender.translation(in: nil).x > 100 ? .right : .left
        let shouldDismissCard = abs(sender.translation(in: nil).x) > 120
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            
            if shouldDismissCard {
                let xTranslation = CGFloat(direction.rawValue) * 1000
                let offScreenTransform = self.transform.translatedBy(x: xTranslation, y: 0)
                
                self.transform = offScreenTransform
            } else {
                self.transform = .identity
            }
        }) { _ in
            if shouldDismissCard {
                self.removeFromSuperview()
            }
        }
    }
}

// MARK: - Actions

extension CardView {
    @objc func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        
        switch sender.state {
        case .began:
            superview?.subviews.forEach({ $0.layer.removeAllAnimations() })
        case .changed:
            panCard(sender)
        case .ended:
            resetCardPosition(sender)
        default: break
        }
    }
    
    @objc func handleChangePhoto(_ sender: UITapGestureRecognizer) {
        print("DEBUG: Did tap on photo")
    }
}
