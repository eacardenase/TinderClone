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
        configureCards()
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
        
        let user1 = User(name: "Jane Done", age: 22, images: [UIImage(named: "jane1")!, UIImage(named: "jane2")!, UIImage(named: "jane3")!])
        let user2 = User(name: "Megan Fox", age: 21, images: [UIImage(named: "kelly1")!, UIImage(named: "kelly2")!, UIImage(named: "kelly3")!])
        
        let cardView1 = CardView(viewModel: CardViewModel(user: user1))
        let cardView2 = CardView(viewModel: CardViewModel(user: user2))
        
        deckView.addSubview(cardView1)
        deckView.addSubview(cardView2)
        
        cardView1.translatesAutoresizingMaskIntoConstraints = false
        cardView2.translatesAutoresizingMaskIntoConstraints = false
        
        // cardView1
        NSLayoutConstraint.activate([
            cardView1.topAnchor.constraint(equalTo: deckView.topAnchor),
            cardView1.leadingAnchor.constraint(equalTo: deckView.leadingAnchor),
            cardView1.trailingAnchor.constraint(equalTo: deckView.trailingAnchor),
            cardView1.bottomAnchor.constraint(equalTo: deckView.bottomAnchor)
        ])
        
        // cardView2
        NSLayoutConstraint.activate([
            cardView2.topAnchor.constraint(equalTo: deckView.topAnchor),
            cardView2.leadingAnchor.constraint(equalTo: deckView.leadingAnchor),
            cardView2.trailingAnchor.constraint(equalTo: deckView.trailingAnchor),
            cardView2.bottomAnchor.constraint(equalTo: deckView.bottomAnchor)
        ])
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
    private func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser == nil {
            presentLoginController()
        } else {
            print("DEBUG: User is logged in")
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            
            presentLoginController()
        } catch {
            print("DEBUG: Failed to sign out \(error.localizedDescription)")
        }
    }
}
