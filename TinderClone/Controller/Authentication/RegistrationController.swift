//
//  RegistrationController.swift
//  TinderClone
//
//  Created by Edwin Cardenas on 3/29/23.
//

import UIKit

class RegistrationController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel = RegistrationViewModel()
    weak var delegate: AuthenticationDelegate?
    
    private let selectPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setImage(UIImage(named: "plus_photo")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        button.clipsToBounds = true
        
        return button
    }()
    private let emailTextField = CustomTextField(placeholderText: "Email")
    private let fullnameTextField = CustomTextField(placeholderText: "Full Name")
    private let passwordTextField = CustomTextField(placeholderText: "Password", isSecure: true)
    
    private var profileImage: UIImage?
    
    private let signupButton: AuthButton = {
        let button = AuthButton(title: "Sign Up", type: .system)
        
        button.addTarget(self, action: #selector(handleRegisterUser), for: .touchUpInside)
        
        return button
    }()
    private let goToLoginButton: UIButton = {
        let button = CustomButton(title: "Already have an account?", subtitle: "Sing in", type: .system)
        
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
        configureTextFieldObservers()
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
    
    func configureTextFieldObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullnameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    func checkFormStatus() {
        if viewModel.formIsValid {
            signupButton.isEnabled = true
            signupButton.backgroundColor = UIColor( red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        } else {
            signupButton.isEnabled = false
            signupButton.backgroundColor = UIColor(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }
    }
}

// MARK: - Actions

extension RegistrationController {
    @objc private func handleSelectPhoto(_ sender: UIButton) {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        
        present(picker, animated: true)
    }
    
    @objc private func handleRegisterUser(_ sender: UIButton) {
        
        guard let email = emailTextField.text else { return }
        guard let fullname = fullnameTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let profileImage = profileImage else {
            
            let ac = UIAlertController(title: "Oops!", message: "You need to add a photo in order to create a profile", preferredStyle: .alert)
            
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
            
            return
        }
        
        let credentials = AuthCredentials(email: email, fullname: fullname, password: password, profileImage: profileImage)
        
        AuthService.registerUser(withCredentials: credentials) { error in
            if let error = error {
                print("DEBUG: Error signing user up: \(error.localizedDescription)")
                
                return
            }
            
            self.delegate?.authenticationComplete()
        }
        
    }
    @objc private func handleShowLogin(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func textDidChange(_ sender: UITextField) {
        if sender === emailTextField {
            viewModel.email = sender.text
        } else if sender === fullnameTextField {
            viewModel.fullname = sender.text
        } else {
            viewModel.password = sender.text
        }
        
        checkFormStatus()
    }
}

// MARK: - UIImagePickerControllerDelegate

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.originalImage] as? UIImage
        
        profileImage = image
        
        selectPhotoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        selectPhotoButton.imageView?.contentMode = .scaleAspectFill
        selectPhotoButton.layer.borderColor = UIColor(white: 1, alpha: 0.7).cgColor
        selectPhotoButton.layer.borderWidth = 3
        selectPhotoButton.layer.cornerRadius = 10
        
        dismiss(animated: true)
    }
    
}
