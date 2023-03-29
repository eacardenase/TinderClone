//
//  RegistrationController.swift
//  TinderClone
//
//  Created by Edwin Cardenas on 3/29/23.
//

import UIKit

class RegistrationController: UIViewController {
    
    // MARK: - Properties
    
    private let selectPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setImage(UIImage(named: "plus_photo")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        
        return button
    }()
    private let emailTextField = CustomTextField(placeholderText: "Email")
    private let fullnameTextField = CustomTextField(placeholderText: "Full Name")
    private let passwordTextField = CustomTextField(placeholderText: "Password", isSecure: true)
    private let signupButton: AuthButton = {
        let button = AuthButton(title: "Sign Up", type: .system)
        
        button.addTarget(self, action: #selector(handleRegisterUser), for: .touchUpInside)
        
        return button
    }()
    private let goToLoginButton: UIButton = {
        let button = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: "Already have an account?  ", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ])
        
        attributedTitle.append(NSAttributedString(string: "Sign in", attributes: [
            .foregroundColor: UIColor.white,
            .font: UIFont.boldSystemFont(ofSize: 16)
        ]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
}

// MARK: - Helpers

extension RegistrationController {
    private func configureUI() {
        configureNavBar()
        configureGradientLayer()
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField, fullnameTextField, passwordTextField, signupButton])
        
        stackView.axis = .vertical
        stackView.spacing = 16
        
        selectPhotoButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        goToLoginButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(selectPhotoButton)
        view.addSubview(stackView)
        view.addSubview(goToLoginButton)
        
        // selectPhotoButton
        NSLayoutConstraint.activate([
            selectPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            selectPhotoButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            selectPhotoButton.heightAnchor.constraint(equalToConstant: 275),
            selectPhotoButton.widthAnchor.constraint(equalTo: selectPhotoButton.heightAnchor)
        ])
        
        // stackView
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: selectPhotoButton.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
        
        // goToLoginButton
        NSLayoutConstraint.activate([
            goToLoginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            goToLoginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            goToLoginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func configureNavBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
}

// MARK: - Actions

extension RegistrationController {
    @objc private func handleSelectPhoto(_ sender: UIButton) {
        print("DEBUG: Handle select photo tapped")
    }
    
    @objc private func handleRegisterUser(_ sender: UIButton) {
        print("DEBUG: Handle sign up tapped")
    }
    @objc private func handleShowLogin(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
