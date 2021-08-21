//
//  LoginViewController.swift
//  MoneyApp
//
//  Created by Szymon Gęsicki on 19/08/2021.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    static func loadFromStoryboard() -> LoginViewController? {
        let storyboard = UIStoryboard(name: "LoginView", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "LoginView") as? LoginViewController
    }
    
    override func viewDidLoad() {
        // from SGSwiftExtensions
        hideKeyboardWhenTappedOutside()
        setupBackground()
        addIcon()
        addHelloText()
        addTextField()
        addLoginButton()
    }

    private let image = UIImageView()
    private let label = UILabel()
    private let usernameTextField = UITextField()
    private let passwordTextField = UITextField()
    private let service = LoginService()
    
    private func addIcon() {
        image.image = UIImage(named: "icon")
        view.addSubview(image)
        
        image.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(view.snp.top).offset(100)
            make.width.height.equalTo(132)
        }
    }
    
    private func addHelloText() {
        label.text = "Hello"
        label.textColor = UIColor.brand.yellow
        // todo add font
        label.font = UIFont.systemFont(ofSize: 32)
        
        view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(image.snp.bottom).offset(39)
        }
    }
    
    private func addTextField() {
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        
        setupTextField(textField: usernameTextField, placeholder: "Username")
        setupTextField(textField: passwordTextField, placeholder: "Password")

        usernameTextField.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(label.snp.bottom).offset(39)
            make.right.left.equalTo(view).inset(34)
            make.height.equalTo(49)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(usernameTextField.snp.bottom).offset(39)
            make.right.left.equalTo(view).inset(34)
            make.height.equalTo(49)
        }
    }
    
    private func setupTextField(textField: UITextField, placeholder: String) {
        textField.textColor = UIColor.white
        textField.backgroundColor = UIColor.brand.darkGray
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.brand.middleGray])

        textField.layer.cornerRadius = 10.0
        // left text offset
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0);

    }

    private func addLoginButton() {
        let button = UIButton()
        view.addSubview(button)
        
        button.setTitle("Log in", for: .normal)
        button.backgroundColor = UIColor.brand.yellow
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.cornerRadius = 10.0

        button.addTarget(self, action: #selector(didPressLogInButton), for: .touchUpInside)
        
        button.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(passwordTextField.snp.bottom).offset(39)
            make.right.left.equalTo(view).inset(34)
        }
    }
    
    @objc private func didPressLogInButton() {
        
        guard let username = usernameTextField.text, !username.isEmpty else {
            Toast.shared.presentToast("Please enter username")
            return
        }
        
        guard let email = passwordTextField.text, !email.isEmpty else {
            Toast.shared.presentToast("Please enter password")
            return
        }
        
        service.login(username: username, password: email, completion: { result in
            switch result {
            
            case .success(let result):
                Toast.shared.presentToast(result)
                self.navigateToGroupList()
                
            case .failure(let error):
                Toast.shared.presentToast(error.localizedDescription)
            }
        })
    }
    
    private func setupBackground() {
        view.backgroundColor = UIColor.black
    }
    
    private func navigateToGroupList() {
        guard let vc = GroupListViewController.loadFromStoryboard() else { return }
        let root = UINavigationController(rootViewController: vc)
        root.modalPresentationStyle = .fullScreen
        present(root, animated: true, completion: nil)
    }
}
