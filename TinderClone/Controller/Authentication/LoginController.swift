//
//  LoginController.swift
//  TinderClone
//
//  Created by Edwin Cardenas on 3/29/23.
//

import UIKit

class LoginController: UIViewController {
    
    // MARK: - Properties
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "app_icon")?.withRenderingMode(.alwaysTemplate) // .alwaysTemplate allows to change color
        imageView.tintColor = .white
        
        return imageView
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
       
        textField.borderStyle = .none
        textField.textColor = .white
        textField.backgroundColor = UIColor(white: 1, alpha: 0.2)
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textField.layer.cornerRadius = 5
        textField.setLeftPaddingPoints(12)
        textField.setRightPaddingPoints(12)
        textField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor(white: 1, alpha: 0.7)
        ])
        
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
       
        textField.borderStyle = .none
        textField.textColor = .white
        textField.backgroundColor = UIColor(white: 1, alpha: 0.2)
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textField.layer.cornerRadius = 5
        textField.setLeftPaddingPoints(12)
        textField.setRightPaddingPoints(12)
        textField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor(white: 1, alpha: 0.7)
        ])
        
        return textField
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
}

// MARK: - Helpers

extension LoginController {
    func configureUI() {
        configureNavBar()
        configureGradientLayer()
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField])
        
        stackView.axis = .vertical
        stackView.spacing = 16
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(iconImageView)
        view.addSubview(stackView)
        
        // iconImageView
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            iconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 100),
            iconImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        // stackView
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
    }
    
    func configureGradientLayer() {
        let topColor = UIColor(red: 0.99, green: 0.36, blue: 0.37, alpha: 1.00)
        let bottomColor = UIColor(red: 0.90, green: 0.00, blue: 0.45, alpha: 1.00)
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0, 1]
        view.layer.addSublayer(gradientLayer)
        gradientLayer.frame = view.frame
    }
    
    func configureNavBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
}
