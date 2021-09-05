//
//  ProfileViewController.swift
//  MoneyApp
//
//  Created by Szymon Gęsicki on 05/09/2021.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    
    private let service = ProfileService()
    private let scrollView = ScrollView()
    private let nameTextField = UITextField()
    private let emailTextField = UITextField()
    
    static func loadFromStoryBoard() -> ProfileViewController? {
        let storyboard = UIStoryboard(name: "ProfileView", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "ProfileView") as? ProfileViewController
    }
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.brand.blackBackground
        setupNavigationController()
        setupScrollView()
        // todo
//        service.fetchUserData(completion: {
//
//        })
        setupContent(user: Mock.shared.fetchUserData())
    }
    
    @objc private func didPressSaveButton() {
        // todo
    }
    
    private func setupNavigationController() {

        navigationController?.setBackgroundColor(color: UIColor.brand.blackBackground)
        title = "Profile"
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.tintColor = UIColor.brand.yellow
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.create()
        scrollView.snp.makeConstraints { make in
            
            make.edges.equalTo(view)
        }
    }
    
    private func setupContent(user: User) {
        appendCircleIcon(name: user.name)
        appendTextField(name: user.name, email: user.email)
        appendSaveButton()
        
    }
    
    private func appendTextField(name: String, email: String) {
        
        nameTextField.defaultStyle(placeholder: "Name")
        emailTextField.defaultStyle(placeholder: "Email")
        
        nameTextField.text = name
        emailTextField.text = email
        
        scrollView.appendVertical(component: nameTextField, last: false)
        scrollView.appendVertical(component: emailTextField, last: false)

        nameTextField.snp.makeConstraints { make in
            make.height.equalTo(49)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(49)
        }
    }
    
    private func appendCircleIcon(name: String) {
        let container = UIView()
    
        let circle = UIView()
        circle.layer.borderWidth = 2
        circle.layer.borderColor = UIColor.brand.yellow.cgColor
        circle.backgroundColor = UIColor.brand.darkGray
        circle.layer.cornerRadius = 60

        container.addSubview(circle)

        circle.snp.makeConstraints { make in
            make.centerX.equalTo(container.snp.centerX)
            make.bottom.top.equalTo(container).inset(25)
            make.height.width.equalTo(120)
        }

        let label = UILabel()
        label.text = String(name.prefix(2)).uppercased()
        label.font = UIFont.boldSystemFont(ofSize: 32)

        circle.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalTo(circle.snp.center)
        }
        
        scrollView.appendVertical(component: container, last: false)
    }
    
    private func appendSaveButton() {
        
        let saveButton = PrimaryButton()
        
        saveButton.setTitle("Save", for: .normal)
        saveButton.backgroundColor = UIColor.brand.yellow
        saveButton.setTitleColor(UIColor.brand.blackBackground, for: .normal)

        saveButton.titleLabel?.textColor = UIColor.brand.blackBackground
        saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        saveButton.layer.cornerRadius = 12
        saveButton.addTarget(self, action: #selector(didPressSaveButton), for: .touchUpInside)
        
        scrollView.appendVertical(component: saveButton, last: true)
    }
}
