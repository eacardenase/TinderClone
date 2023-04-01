//
//  SettingsController.swift
//  TinderClone
//
//  Created by Edwin Cardenas on 3/31/23.
//

import UIKit

class SettingsController: UITableViewController {
    
    // MARK: - Properties
    
    private let headerView = SettingsHeader()
    private let imagePicker = UIImagePickerController()
    private var imageIndex = 0
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.delegate = self
        imagePicker.delegate = self
        
        configureUI()
    }
}

// MARK: - Helpers

extension SettingsController {
    private func configureUI() {
        navigationItem.title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .blue
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDone))
        
        tableView.separatorStyle = .none
        
        tableView.tableHeaderView = headerView
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 300)
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
        print("DEBUG: Handle did drop done")
    }
}

// MARK: - SettingsHeaderDelegate

extension SettingsController: SettingsHeaderDelegate {
    func settingsHeader(_ header: SettingsHeader, didSelect index: Int) {
        imageIndex = index
        
        present(imagePicker, animated: true)
    }
}

// MARK: - UIImagePickerControllerDelegate

extension SettingsController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.originalImage] as? UIImage
        
        // update button's photo
        setHeaderImage(image)

        dismiss(animated: true)
    }
    
}
