//
//  SettingsCell.swift
//  TinderClone
//
//  Created by Edwin Cardenas on 4/1/23.
//

import UIKit

protocol SettingsCellDelegate: AnyObject {
    func settingsCell(_ cell: SettingsCell, updateUserWith value: String, for section: SettingsSections)
    func settingsCell(_ cell: SettingsCell, updateAgeRangeWith value: UISlider)
}

class SettingsCell: UITableViewCell {
    
    // MARK: Properties
    
    weak var delegate: SettingsCellDelegate?
    
    var viewModel: SettingsViewModel! {
        didSet {
            configureCell()
        }
    }
    
    static let reuseIdentifier = "SettingsCell"
    
    lazy var inputField: UITextField = {
        let textField = UITextField()
        
        textField.borderStyle = .none
        textField.font = UIFont.systemFont(ofSize: 16)
        
        let paddingView = UIView()
        paddingView.setDimensions(height: 50, width: 28)
        
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        textField.addTarget(self, action: #selector(handleUpdateUserInfo), for: .editingDidEnd)
        
        return textField
    }()
    
    let minAgeLabel = UILabel()
    let maxAgeLabel = UILabel()
    
    lazy var minAgeSlider = createAgeRangeSlider()
    lazy var maxAgeSlider = createAgeRangeSlider()
    
    var sliderStackView = UIStackView()
    
    // MARK: Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers

extension SettingsCell {
    
    private func configureUI () {
        
        selectionStyle = .none
        
        let minStackView = UIStackView(arrangedSubviews: [minAgeLabel, minAgeSlider])
        minStackView.spacing = 24
        
        let maxStackView = UIStackView(arrangedSubviews: [maxAgeLabel, maxAgeSlider])
        maxStackView.spacing = 24
        
        sliderStackView.addArrangedSubview(minStackView)
        sliderStackView.addArrangedSubview(maxStackView)
        sliderStackView.axis = .vertical
        sliderStackView.spacing = 16
        
        inputField.translatesAutoresizingMaskIntoConstraints = false
        sliderStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // in order to interact with these controls within the cell
        contentView.addSubview(inputField)
        contentView.addSubview(sliderStackView)
        
        // inputField
        NSLayoutConstraint.activate([
            inputField.topAnchor.constraint(equalTo: topAnchor),
            inputField.leadingAnchor.constraint(equalTo: leadingAnchor),
            inputField.trailingAnchor.constraint(equalTo: trailingAnchor),
            inputField.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        // sliderStack
        NSLayoutConstraint.activate([
            sliderStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            sliderStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            sliderStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24)
        ])
    }
    
    private func configureCell() {
        inputField.isHidden = viewModel.shouldHideInputField
        sliderStackView.isHidden = viewModel.shouldHideSlider
        
        inputField.placeholder = viewModel.placeholderText
        inputField.text = viewModel.value
        
        minAgeSlider.setValue(viewModel.minAgeSliderValue, animated: true)
        maxAgeSlider.setValue(viewModel.maxAgeSliderValue, animated: true)
        
        minAgeLabel.text = viewModel.minAgeLabelText(forValue: viewModel.minAgeSliderValue)
        maxAgeLabel.text = viewModel.maxAgeLabelText(forValue: viewModel.maxAgeSliderValue)
    }
    
    private func createAgeRangeSlider() -> UISlider{
        let slider = UISlider()
        
        slider.minimumValue = 18
        slider.maximumValue = 60
        slider.addTarget(self, action: #selector(handleAgeRangeChanged), for: .valueChanged)
        
        return slider
    }
}

// MARK: - Actions

extension SettingsCell {
    @objc private func handleAgeRangeChanged(_ sender: UISlider) {
        if sender == minAgeSlider {
            minAgeLabel.text = viewModel.minAgeLabelText(forValue: sender.value)
        } else {
            maxAgeLabel.text = viewModel.maxAgeLabelText(forValue: sender.value)
        }
        
        delegate?.settingsCell(self, updateAgeRangeWith: sender)
    }
    
    @objc private func handleUpdateUserInfo(_ sender: UITextField) {
        
        guard let value = sender.text else { return }
        
        delegate?.settingsCell(self, updateUserWith: value, for: viewModel.section)
    }
}
