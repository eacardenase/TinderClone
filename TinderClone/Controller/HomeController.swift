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
    
    private var user: User?
    private var viewModels = [CardViewModel]() {
        didSet {
            configureCards()
        }
    }
    
    private var topCardView: CardView?
    private var cardViews = [CardView]()
    
    private let topStack = HomeNavigationStackView()
    private let deckView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        
        return view
    }()
    private let bottomStack = BottomControlsStackView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topStack.delegate = self
        bottomStack.delegate = self
        
        checkIfUserIsLoggedIn()
        configureUI()
        fetchUser()
        fetchUsers()
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
            cardView.delegate = self
            
            deckView.addSubview(cardView)
            
            NSLayoutConstraint.activate([
                cardView.topAnchor.constraint(equalTo: deckView.topAnchor),
                cardView.leadingAnchor.constraint(equalTo: deckView.leadingAnchor),
                cardView.trailingAnchor.constraint(equalTo: deckView.trailingAnchor),
                cardView.bottomAnchor.constraint(equalTo: deckView.bottomAnchor)
            ])
            
            cardViews.append(cardView)
        }
        
//        cardViews = deckView.subviews.map({ ($0 as? CardView)! })
        topCardView = cardViews.last
    }
    
    private func presentLoginController() {
        DispatchQueue.main.async {
            let controller = LoginController()
            let nav = UINavigationController(rootViewController: controller)
            
            nav.modalPresentationStyle = .fullScreen
            
            self.present(nav, animated: true)
        }
    }
    
    private func performSwipeAnimation(withCard card: CardView, shouldLike: Bool) {
        
        let translation: CGFloat = shouldLike ? 1000 : -1000
        let degrees: CGFloat = translation / 70
        let angle = degrees * .pi / 180
        let rotationalTransform = CGAffineTransform(rotationAngle: angle)
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut) {
            
//            card.frame = CGRect(x: translation, y: 0, width: card.frame.width, height: card.frame.height)
            card.transform = rotationalTransform.translatedBy(x: translation, y: 0)
            
        } completion: { _ in
            card.removeFromSuperview()
            
            guard !self.cardViews.isEmpty else { return }
            
            self.cardViews.remove(at: self.cardViews.count - 1)
            self.topCardView = self.cardViews.last
        }
    }
}

// MARK: - API

extension HomeController {
    
    private func fetchUser() {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Service.fetchUser(withUid: uid) { user in
            self.user = user
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

// MARK: - HomeNavigationStackViewDelegate

extension HomeController: HomeNavigationStackViewDelegate {
    
    func showSettings() {
        
        guard let user = self.user else { return }
        
        let controller = SettingsController(user: user)
        controller.delegate = self
        
        let nav = UINavigationController(rootViewController: controller)
        
        nav.modalPresentationStyle = .fullScreen
        
        present(nav, animated: true)
    }
    
    func showMessages() {
        print("DEBUG: Show messages")
    }
}

// MARK: - SettingsControllerDelegate

extension HomeController: SettingsControllerDelegate {
    func settingsController(_ controller: SettingsController, wantsToUpdate user: User) {
        self.user = user
        
        controller.dismiss(animated: true)
    }
    
    func settingsControllerWantsToLogout(_ controller: SettingsController) {
        
        controller.dismiss(animated: true)
        
        logout()
    }
}

// MARK: - CardViewDelegate

extension HomeController: CardViewDelegate {
    func cardView(_ view: CardView, wantsToShowProfileFor user: User) {
        let controller = ProfileController(user: user)
        
        controller.modalPresentationStyle = .fullScreen
        
        present(controller, animated: true)
    }
}

// MARK: - BottomControllerStackViewDelegate

extension HomeController: BottomControllerStackViewDelegate {
    func handleLike() {
        guard let topCard = topCardView else { return }
        
        performSwipeAnimation(withCard: topCard, shouldLike: true)
    }
    
    func handleDislike() {
        guard let topCard = topCardView else { return }
        
        performSwipeAnimation(withCard: topCard, shouldLike: false)
    }
    
    func handleRefresh() {
        print("DEBUG: Handle refreshing here")
    }
}
