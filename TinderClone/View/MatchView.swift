//
//  MatchView.swift
//  TinderClone
//
//  Created by Edwin Cardenas on 4/10/23.
//

import UIKit

class MatchView: UIView {
    
    // MARK: - Properties
    
    private let viewModel: MatchViewViewModel
    
    private let matchImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "itsamatch")
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        
        return label
    }()
    
    private let currentUserImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.white.cgColor
        
        return imageView
    }()
    
    private let matchedUserImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.white.cgColor
        
        return imageView
    }()
    
    private let imageViewDimension: CGFloat = 140
    
    private let sendMessageButton: UIButton = {
        let button = SendMessageButton(type: .system)
        
        button.setTitle("SEND MESSAGE", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapSendMessage), for: .touchUpInside)
        
        return button
    }()
    
    private let keepSwipingButton: UIButton = {
        let button = KeepSwipingButton(type: .system)
        
        button.setTitle("Keep Swiping", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapKeepSwiping), for: .touchUpInside)
        
        return button
    }()
    
    let visualEffectView: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blur)
        
        view.alpha = 0
        
        return view
    }()
    
    lazy var views = [
        matchImageView,
        descriptionLabel,
        currentUserImageView,
        matchedUserImageView,
        sendMessageButton,
        keepSwipingButton
    ]
    
    // MARK: - Lifecycle
    
    init(viewModel: MatchViewViewModel) {
        self.viewModel = viewModel
        
        super.init(frame: .zero)
        
        loadUserData()
        configureBlurView()
        configureUI()
        configureAnimations()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: 200, height: 200)
    }
}

// MARK: - Helpers

extension MatchView {
    private func loadUserData() {
        descriptionLabel.text = viewModel.matchLabelText
        currentUserImageView.sd_setImage(with: viewModel.currentUserImageURL)
        matchedUserImageView.sd_setImage(with: viewModel.matchedUserImageURL)
    }

    private func configureBlurView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleDismissal))
        
        visualEffectView.addGestureRecognizer(tap)
        
        addSubview(visualEffectView)
        
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        
        // visualEffectView
        NSLayoutConstraint.activate([
            visualEffectView.topAnchor.constraint(equalTo: topAnchor),
            visualEffectView.leadingAnchor.constraint(equalTo: leadingAnchor),
            visualEffectView.trailingAnchor.constraint(equalTo: trailingAnchor),
            visualEffectView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.visualEffectView.alpha = 1
        }, completion: nil)
    }
    
    private func configureUI() {
        views.forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            view.alpha = 0

            addSubview(view)
        }
        
        // currentUserImageView
        NSLayoutConstraint.activate([
            currentUserImageView.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -16),
            currentUserImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            currentUserImageView.heightAnchor.constraint(equalToConstant: imageViewDimension),
            currentUserImageView.widthAnchor.constraint(equalToConstant: imageViewDimension),
        ])
        
        currentUserImageView.layer.cornerRadius = imageViewDimension / 2
        
        // matchedUserImageView
        NSLayoutConstraint.activate([
            matchedUserImageView.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 16),
            matchedUserImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            matchedUserImageView.heightAnchor.constraint(equalToConstant: imageViewDimension),
            matchedUserImageView.widthAnchor.constraint(equalToConstant: imageViewDimension),
        ])
        
        matchedUserImageView.layer.cornerRadius = imageViewDimension / 2

        // sendMessageButton
        NSLayoutConstraint.activate([
            sendMessageButton.topAnchor.constraint(equalTo: currentUserImageView.bottomAnchor, constant: 32),
            sendMessageButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 48),
            sendMessageButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -48),
            sendMessageButton.heightAnchor.constraint(equalToConstant: 60)
        ])

        // keepSwipingButton
        NSLayoutConstraint.activate([
            keepSwipingButton.topAnchor.constraint(equalTo: sendMessageButton.bottomAnchor, constant: 16),
            keepSwipingButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 48),
            keepSwipingButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -48),
            keepSwipingButton.heightAnchor.constraint(equalToConstant: 60)
        ])

        // descriptionLabel
        NSLayoutConstraint.activate([
            descriptionLabel.bottomAnchor.constraint(equalTo: currentUserImageView.topAnchor, constant: -32),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])

        // matchImageView
        NSLayoutConstraint.activate([
            matchImageView.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -16),
            matchImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            matchImageView.heightAnchor.constraint(equalToConstant: 80),
            matchImageView.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    private func configureAnimations() {
        views.forEach({ $0.alpha = 1 })
        
        let angle = 30 * CGFloat.pi / 180
        
        currentUserImageView.transform = CGAffineTransform(rotationAngle: angle)
            .concatenating(CGAffineTransform(translationX: 200, y: 0))
        matchedUserImageView.transform = CGAffineTransform(rotationAngle: -angle)
            .concatenating(CGAffineTransform(translationX: -200, y: 0))
        
        self.sendMessageButton.transform = CGAffineTransform(translationX: 500, y: 0)
        self.keepSwipingButton.transform = CGAffineTransform(translationX: -500, y: 0)
        
        UIView.animateKeyframes(withDuration: 1.3, delay: 0, options: .calculationModeCubic, animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.45) {
                self.currentUserImageView.transform = CGAffineTransform(rotationAngle: -angle)
                self.matchedUserImageView.transform = CGAffineTransform(rotationAngle: -angle)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.4) {
                self.currentUserImageView.transform = .identity
                self.matchedUserImageView.transform = .identity
            }
            
        }, completion: nil)
        
        UIView.animate(withDuration: 0.75, delay: 0.6 * 1.3, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            self.sendMessageButton.transform = .identity
            self.keepSwipingButton.transform = .identity
        }, completion: nil)
    }
}

// MARK: - Actions

extension MatchView {
    @objc func didTapSendMessage(_ sender: UIButton) {
        
    }
    
    @objc func didTapKeepSwiping(_ sender: UIButton) {
        
    }
    
    @objc func handleDismissal() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.alpha = 0
        } completion: { _ in
            self.removeFromSuperview()
        }
    }
}
