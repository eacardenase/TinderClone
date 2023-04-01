//
//  HomeController.swift
//  TinderClone
//
//  Created by Edwin Cardenas on 3/25/23.
//

import UIKit
import FirebaseAuth

class HomeController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModels = [CardViewModel]() {
        didSet {
            configureCards()
        }
    }
    
    private let topStack = HomeNavigationStackView()
    private let deckView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .systemPink
        view.layer.cornerRadius = 5
        
        return view
    }()
    private let bottomStack = BottomControlsStackView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkIfUserIsLoggedIn()
        configureUI()
        fetchUser()
        fetchUsers()
//        logout()
    }
    
}

// MARK: - Helpers

extension HomeController {
    
    func configureUI() {
        view.backgroundColor = .white
        
        let stackView = UIStackView(arrangedSubviews: [topStack, deckView, bottomStack])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
                
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        stackView.bringSubviewToFront(deckView)
    }
    
    func configureCards() {
        
        viewModels.forEach { viewModel in
            let cardView = CardView(viewModel: viewModel)
            
            cardView.translatesAutoresizingMaskIntoConstraints = false
            
            deckView.addSubview(cardView)
            
            NSLayoutConstraint.activate([
                cardView.topAnchor.constraint(equalTo: deckView.topAnchor),
                cardView.leadingAnchor.constraint(equalTo: deckView.leadingAnchor),
                cardView.trailingAnchor.constraint(equalTo: deckView.trailingAnchor),
                cardView.bottomAnchor.constraint(equalTo: deckView.bottomAnchor)
            ])
        }
    }
    
    private func presentLoginController() {
        DispatchQueue.main.async {
            let controller = LoginController()
            let nav = UINavigationController(rootViewController: controller)
            
            nav.modalPresentationStyle = .fullScreen
            
            self.present(nav, animated: true)
        }
    }
}

// MARK: - API

extension HomeController {
    
    private func fetchUser() {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Service.fetchUser(withUid: uid) { user in
            
            print("DEBUG: User name is \(user.name)")
            
        }
    }
    
    private func fetchUsers() {
        
        Service.fetchUsers { users in
            self.viewModels = users.map({ CardViewModel(user: $0) })
        }
        
    }
    
    private func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser == nil {
            presentLoginController()
        } else {
            print("DEBUG: User is logged in")
        }
    }
    
    private func logout() {
        do {
            try Auth.auth().signOut()
            
            presentLoginController()
        } catch {
            print("DEBUG: Failed to sign out \(error.localizedDescription)")
        }
    }
}
