//
//  AuthenticationViewModel.swift
//  TinderClone
//
//  Created by Edwin Cardenas on 3/30/23.
//

import UIKit

protocol AuthenticationViewModelProtocol {
    var formIsValid: Bool { get }
}

struct LoginViewModel: AuthenticationViewModelProtocol {
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false
         && password?.isEmpty == false
    }
}

struct RegistrationViewModel: AuthenticationViewModelProtocol {
    var email: String?
    var fullname: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false
        && fullname?.isEmpty == false
        && password?.isEmpty == false
    }
}
