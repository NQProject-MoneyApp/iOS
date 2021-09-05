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
    private var user: User?
    let saveButton = PrimaryButton()

    static func loadFromStoryBoard() -> ProfileViewController? {
        let storyboard = UIStoryboard(name: "ProfileView", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "ProfileView") as? ProfileViewController
    }
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.brand.blackBackground
        setupNavigationController()
        setupScrollView()
        
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = UIColor.brand.yellow
        activityIndicator.startAnimating()
        scrollView.setSingleContent(content: activityIndicator)

        service.fetchUser(completion: { user in
            if let user = user {
                self.user = user
                self.setupContent(user: user)
                self.scrollView.alpha = 0
                self.scrollView.fadeIn(0.5)
            } else {
                Toast.shared.presentToast("Error on fetch user data")
            }
        })
    }
    
    @objc private func didPressSaveButton() {
        guard let user = user else { return }
        user.name = nameTextField.text ?? ""
        user.email = emailTextField.text ?? ""
        service.updateUser(user: user, completion: { result in
            Toast.shared.presentToast(result)
        })
    }
    
    @objc private func textFieldDidChange(_ sender: Any) {
        
        if emailTextField.text != user?.email || nameTextField.text != user?.name {
            saveButton.isEnabled = true
            saveButton.backgroundColor = UIColor.brand.yellow
            saveButton.setTitleColor(UIColor.brand.blackBackground, for: .normal)

        } else {
            saveButton.isEnabled = false
            saveButton.backgroundColor = UIColor.brand.gray
            saveButton.setTitleColor(UIColor.white, for: .normal)
        }
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
        scrollView.clearComponents()
        appendCircleIcon(name: user.name)
        appendTextField(name: user.name, email: user.email)
        appendSaveButton()
    }
    
    private func appendTextField(name: String, email: String) {
        
        nameTextField.defaultStyle(placeholder: "Name")
        emailTextField.defaultStyle(placeholder: "Email")
        
        nameTextField.text = name
        emailTextField.text = email
        
        nameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)

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
        label.textColor = UIColor.brand.middleGray

        circle.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalTo(circle.snp.center)
        }
        
        scrollView.appendVertical(component: container, last: false)
    }
    
    private func appendSaveButton() {
                
        saveButton.setTitle("Save", for: .normal)
        saveButton.isEnabled = false
        saveButton.backgroundColor = UIColor.brand.gray
        saveButton.setTitleColor(UIColor.white, for: .normal)
        saveButton.titleLabel?.textColor = UIColor.brand.blackBackground
        saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        saveButton.layer.cornerRadius = 12
        saveButton.addTarget(self, action: #selector(didPressSaveButton), for: .touchUpInside)
        
        scrollView.appendVertical(component: saveButton, last: true)
    }
}
