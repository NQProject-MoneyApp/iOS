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
        navigationController?.navigationBar.isHidden = true
        // from SGSwiftExtensions
        hideKeyboardWhenTappedOutside()
        setupBackground()
        addIcon()
        addHelloText()
        addTextField()
        addLoginButton()
        addBottomTexts()
    }

    private let image = UIImageView()
    private let label = UILabel()
    private let usernameTextField = UITextField()
    private let passwordTextField = UITextField()
    private let loginButton = PrimaryButton()
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
        
        usernameTextField.defaultStyle(placeholder: "Username")
        passwordTextField.defaultStyle(placeholder: "Password")
        passwordTextField.isSecureTextEntry = true
 
        usernameTextField.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(label.snp.bottom).offset(39)
            make.right.left.equalTo(view).inset(34)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(usernameTextField.snp.bottom).offset(21)
            make.right.left.equalTo(view).inset(34)
        }
    }

    private func addLoginButton() {
        view.addSubview(loginButton)
        
        loginButton.defaultStyle(title: "Log in")

        loginButton.addTarget(self, action: #selector(didPressLogInButton), for: .touchUpInside)
        
        loginButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(passwordTextField.snp.bottom).offset(21)
            make.right.left.equalTo(view).inset(34)
        }
    }
    
    private func addBottomTexts() {
        let registerView = TextWithButton()
        registerView.create(
            labelText: "No account yet?", buttonText: "Register", onTap: { [self] in self.navigateToRegister() })
        view.addSubview(registerView)
        
        registerView.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(loginButton.snp.bottom).offset(20)
        }
    }
    
    private func createBottomText(labelText: String, buttonText: String, onTap: Selector) -> UIView {
        let container = UIView()
        view.addSubview(container)
        let text = UILabel()
        
        text.text = labelText
        text.textColor = UIColor.white
        text.font = UIFont.systemFont(ofSize: 18)
        
        container.addSubview(text)
        
        text.snp.makeConstraints { make in
            make.left.equalTo(container.snp.left)
            make.centerY.equalTo(container.snp.centerY)
            make.top.equalTo(container.snp.top)
            make.bottom.equalTo(container.snp.bottom)
        }
        
        let resetButton = UIButton()
        resetButton.setTitle(buttonText, for: .normal)
        resetButton.setTitleColor(UIColor.brand.yellow, for: .normal)
        
        resetButton.addTarget(self, action: onTap, for: .touchUpInside)
        
        container.addSubview(resetButton)
    
        resetButton.snp.makeConstraints { make in
            make.left.equalTo(text.snp.right).offset(13)
            make.right.equalTo(container.snp.right)
            make.centerY.equalTo(container.snp.centerY)
        }
        return container
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
    
    @objc private func navigateToForgot() {
        Toast.shared.presentToast("Password reset not implemented yet!")
    }
    
    @objc private func navigateToRegister() {
        guard let vc = RegisterViewController.loadFromStoryboard() else { return }
        navigationController?.pushViewController(vc, animated: true)
    }
}
