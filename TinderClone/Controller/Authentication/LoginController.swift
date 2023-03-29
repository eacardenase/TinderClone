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
    
    private let emailTextField = CustomTextField(placeholderText: "Email")
    private let passwordTextField = CustomTextField(placeholderText: "Password", isSecure: true)
    private let authButton: AuthButton = {
        let button = AuthButton(title: "Log In", type: .system)
        
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        
        return button
    }()
    
    private let goToRegistrationButton: UIButton = {
        let button = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: "Don't have an accouny?  ", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ])
        
        attributedTitle.append(NSAttributedString(string: "Sign Up", attributes: [
            .foregroundColor: UIColor.white,
            .font: UIFont.boldSystemFont(ofSize: 16)
        ]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowRegistration), for: .touchUpInside)
        
        return button
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
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, authButton])
        
        stackView.axis = .vertical
        stackView.spacing = 16
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        goToRegistrationButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(iconImageView)
        view.addSubview(stackView)
        view.addSubview(goToRegistrationButton)
        
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
        
        // goToRegistrationButton
        NSLayoutConstraint.activate([
            goToRegistrationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            goToRegistrationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            goToRegistrationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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

// MARK: - Actions

extension LoginController {
    @objc private func handleLogin(_ sender: UIButton) {
        print("DEBUG: Login button tapped")
    }
    
    @objc private func handleShowRegistration(_ sender: UIButton) {
        
        navigationController?.pushViewController(RegistrationController(), animated: true)
    }
}
