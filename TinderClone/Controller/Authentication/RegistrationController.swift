//
//  RegistrationController.swift
//  TinderClone
//
//  Created by Edwin Cardenas on 3/29/23.
//

import UIKit

class RegistrationController: UIViewController {
    
    // MARK: - Properties
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
}

// MARK: - Helpers

extension RegistrationController {
    private func configureUI() {
        view.backgroundColor = .systemPurple
    }
}
