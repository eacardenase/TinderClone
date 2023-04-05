//
//  SettingsViewModel.swift
//  TinderClone
//
//  Created by Edwin Cardenas on 4/1/23.
//

import Foundation

enum SettingsSections: Int, CaseIterable {
    case name
    case profession
    case age
    case bio
    case ageRange
    
    var description: String {
        switch self {
        case .name: return "Name"
        case .profession: return "Profession"
        case .age: return "Age"
        case .bio: return "Bio"
        case .ageRange: return "Seeking Age Range"
        }
    }
}

struct SettingsViewModel {
    
    private let user: User
    
    let section: SettingsSections
    
    var value: String?
    
    let placeholderText: String
    
    var shouldHideInputField: Bool {
        section == .ageRange
    }
    var shouldHideSlider: Bool {
        section != .ageRange
    }
    
    init(user: User, section: SettingsSections) {
        self.user = user
        self.section = section
        self.placeholderText = "Enter \(section.description.lowercased())"
        
        switch section {
        case .name:
            value = user.name
        case .profession:
            value = user.profession
        case .age:
            value = "\(user.age)"
        case .bio:
            value = user.bio
        case .ageRange:
            break
        }
    }
}
