//
//  SettingsViewController.swift
//  NewsApp
//
//  Created by Муслим on 16.04.2024.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Режим отображения карусели"
        return label
    }()
    
    private let actionSwitch: UISwitch = {
        let actionSwitch = UISwitch()
        actionSwitch.translatesAutoresizingMaskIntoConstraints = false
        return actionSwitch
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        actionSwitch.isOn = UserDefaults.standard.bool(forKey: "actionSwitch")
        
        title = "Settings"
        
        actionSwitch.addTarget(self, action: #selector(actionSwitchToggle), for: .valueChanged)
        
        setupTitleLabelLayout()
        setupActionSwitchLayout()
        actionSwitchToggle()
    }
    
    private func setupTitleLabelLayout() {
        view.addSubview(titleLabel)
        
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
    }
    
    private func setupActionSwitchLayout() {
        view.addSubview(actionSwitch)
        
        actionSwitch.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        actionSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -48).isActive = true
    }
    
    @objc
    private func actionSwitchToggle() {
        UserDefaults.standard.set(actionSwitch.isOn, forKey: "actionSwitch")
    }
}
