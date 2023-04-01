//
//  SettingsHeader.swift
//  TinderClone
//
//  Created by Edwin Cardenas on 4/1/23.
//

import UIKit

protocol SettingsHeaderDelegate: AnyObject {
    func settingsHeader(_ header: SettingsHeader, didSelect index: Int)
}

class SettingsHeader: UIView {
    
    // MARK: - Properties
    
    weak var delegate: SettingsHeaderDelegate?
    
    var buttons = [UIButton]()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: 200, height: 200)
    }
}

// MARK: - Helpers

extension SettingsHeader {
    private func configureUI() {
        backgroundColor = .systemGroupedBackground
        
        let button1 = createButton(0)
        let button2 = createButton(1)
        let button3 = createButton(2)
        let stackView = UIStackView(arrangedSubviews: [button2, button3])
        
        button1.translatesAutoresizingMaskIntoConstraints = false
        button2.translatesAutoresizingMaskIntoConstraints = false
        button3.translatesAutoresizingMaskIntoConstraints = false
        
        buttons.append(contentsOf: [button1, button2, button3])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        
        addSubview(button1)
        addSubview(stackView)
        
        // button1
        NSLayoutConstraint.activate([
            button1.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            button1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            button1.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            button1.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.45)
        ])
        
        // stackView
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: button1.trailingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    private func createButton(_ index: Int) -> UIButton {
        let button = UIButton(type: .system)
        
        button.setTitle("Select photo", for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        button.clipsToBounds = true
        button.backgroundColor = .white
        button.imageView?.contentMode = .scaleAspectFill
        button.tag = index
        
        return button
    }
}

// MARK: - Actions

extension SettingsHeader {
    @objc private func handleSelectPhoto(_ sender: UIButton) {
        delegate?.settingsHeader(self, didSelect: sender.tag)
    }
}
