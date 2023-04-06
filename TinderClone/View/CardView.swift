//
//  CardView.swift
//  TinderClone
//
//  Created by Edwin Cardenas on 3/28/23.
//

import UIKit
import SDWebImage

enum SwipeDirection: Int {
    case left = -1
    case right = 1
}

protocol CardViewDelegate: AnyObject {
    func cardView(_ view: CardView, wantsToShowProfileFor user: User)
}

class CardView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: CardViewDelegate?
    
    private let viewModel: CardViewModel
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 2
        label.attributedText = viewModel.userInfoText
        
        return label
    }()
    
    private lazy var infoButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "info_icon")?.withRenderingMode(.alwaysOriginal), for: .normal) // .alwaysOriginal prevents the image to turn sligthly blue
        button.addTarget(self, action: #selector(handleShowProfile), for: .touchUpInside)
        
        return button
    }()
    
    private let gradientLayer = CAGradientLayer()
    private lazy var barStackView = SegmentedBarView(numberOfSegments: viewModel.imageURLs.count)
    
    // MARK: - Lifecycle
    
    init(viewModel: CardViewModel) {
        
        self.viewModel = viewModel
        
        super.init(frame: .zero)
        
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
        
        layer.cornerRadius = 10
        clipsToBounds = true
        
        imageView.sd_setImage(with: viewModel.imageURL)

        addSubview(imageView)
        
        configureBarStackView()
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
    
    private func configureBarStackView() {
        
        barStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(barStackView)
        
        // barStackView
        NSLayoutConstraint.activate([
            barStackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            barStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            barStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            barStackView.heightAnchor.constraint(equalToConstant: 4)
        ])
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
        let location = sender.location(in: nil).x
        let shouldShowNextPhoto = location > self.frame.width / 2
        
        if shouldShowNextPhoto {
            viewModel.showNextPhoto()
        } else {
            viewModel.showPreviousPhoto()
        }
        
        imageView.sd_setImage(with: viewModel.imageURL)
        
        barStackView.setHighlightedBar(viewModel.index)
    }
    
    @objc func handleShowProfile(_ sender: UIButton) {
        delegate?.cardView(self, wantsToShowProfileFor: viewModel.user)
    }
}
