//
//  HomeController.swift
//  TinderClone
//
//  Created by Edwin Cardenas on 3/25/23.
//

import UIKit

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
        
        configureUI()
        configureCards()
    }
    
}

extension HomeController {
    
    // MARK: - Helpers
    
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
        let cardView1 = CardView()
        let cardView2 = CardView()
        
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
}
