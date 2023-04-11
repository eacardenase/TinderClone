//
//  SettingsController.swift
//  TinderClone
//
//  Created by Edwin Cardenas on 3/31/23.
//

import UIKit
import JGProgressHUD

protocol SettingsControllerDelegate: AnyObject {
    func settingsController(_ controller: SettingsController, wantsToUpdate user: User)
    func settingsControllerWantsToLogout(_ controller: SettingsController)
}

class SettingsController: UITableViewController {
    
    // MARK: - Properties
    
    private var user: User
    weak var delegate: SettingsControllerDelegate?
    
    private lazy var headerView = SettingsHeader(viewModel: SettingsHeaderViewModel(user: user))
    private lazy var footerView = SettingsFooter()
    private let imagePicker = UIImagePickerController()
    private var imageIndex = 0
    
    // MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
        
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.delegate = self
        imagePicker.delegate = self
        footerView.delegate = self
    
        configureUI()
    }
}

// MARK: - Helpers

extension SettingsController {
    private func configureUI() {
        
        configureBar()
        
        tableView.separatorStyle = .none
        tableView.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.reuseIdentifier)
        tableView.backgroundColor = .systemGroupedBackground
        
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 300)
        tableView.tableHeaderView = headerView
        
        footerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 88)
        tableView.tableFooterView = footerView
    }
    
    private func configureBar() {
        navigationItem.title = "Settings"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDone))
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .black
    }
    
    private func setHeaderImage(_ image: UIImage?) {
        headerView.buttons[imageIndex].setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
}

// MARK: - Actions

extension SettingsController {
    @objc private func handleCancel(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @objc private func handleDone(_ sender: UIButton) {
        let hud = JGProgressHUD(style: .dark)
        
        hud.textLabel.text = "Saving your data"
        hud.show(in: view)
        
        view.endEditing(true)
        
        Service.saveUserData(user: user) { error in
            self.delegate?.settingsController(self, wantsToUpdate: self.user)
            
            hud.dismiss()
        }
    }
}

// MARK: - SettingsHeaderDelegate

extension SettingsController: SettingsHeaderDelegate {
    func settingsHeader(_ header: SettingsHeader, didSelect index: Int) {
        imageIndex = index
        
        present(imagePicker, animated: true)
    }
}

// MARK: - SettingsFooterDelegate

extension SettingsController: SettingsFooterDelegate {
    func handleLogout() {
        delegate?.settingsControllerWantsToLogout(self)
    }
}

// MARK: - UIImagePickerControllerDelegate

extension SettingsController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else { fatalError("Image cannot be uploaded") }
        
        // update button's photo
        uploadImage(image)
        
        setHeaderImage(image)

        dismiss(animated: true)
    }
    
}

// MARK: - UITableViewDataSource

extension SettingsController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return SettingsSections.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.reuseIdentifier, for: indexPath) as? SettingsCell
            else { fatalError("Error downcasting table view cell into SettingsCell") }
        
        guard let section = SettingsSections(rawValue: indexPath.section) else { return cell }
        
        let viewModel = SettingsViewModel(user: user, section: section)
        
        cell.viewModel = viewModel
        cell.delegate = self
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension SettingsController {
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        32
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = SettingsSections(rawValue: section) else { return nil }
        
        return section.description
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = SettingsSections(rawValue: indexPath.section) else { return 0 }
        
        return section == .ageRange ? 96 : 44
    }
}

// MARK: - SettingsCellDelegate

extension SettingsController: SettingsCellDelegate {
    func settingsCell(_ cell: SettingsCell, updateUserWith value: String, for section: SettingsSections) {
        
        switch section {
        case .name:
            user.name = value
        case .profession:
            user.profession = value
        case .age:
            user.age = Int(value) ?? user.age
        case .bio:
            user.bio = value
        case .ageRange:
            break
        }
    }
    
    func settingsCell(_ cell: SettingsCell, updateAgeRangeWith sender: UISlider) {
        if sender == cell.minAgeSlider {
            user.minSeekingAge = Int(sender.value)
        } else {
            user.maxSeekingAge = Int(sender.value)
        }
    }
}

// MARK: - API

extension SettingsController {
    func uploadImage(_ image: UIImage) {
        let hud = JGProgressHUD(style: .dark)
        
        hud.textLabel.text = "Saving Image"
        hud.show(in: view)
        
        Service.uploadImage(image: image) { imageURL in
            
            if self.user.imageURLs[safe: self.imageIndex] == nil {
                self.user.imageURLs.append(imageURL)
            } else {
                self.user.imageURLs[self.imageIndex] = imageURL
            }
            
            hud.dismiss()
        }
    }
}
