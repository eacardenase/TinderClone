//
//  ProfileController.swift
//  TinderClone
//
//  Created by Edwin Cardenas on 4/6/23.
//

import UIKit

class ProfileController: UIViewController {
    
    // MARK: - Properties
    
    private let user: User
    
    // MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
}

extension ProfileController {
    private func configureUI() {
        view.backgroundColor = .white
    }
}
