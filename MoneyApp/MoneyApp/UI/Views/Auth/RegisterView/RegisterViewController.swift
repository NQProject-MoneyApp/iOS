//
//  RegisterViewController.swift
//  MoneyApp
//
//  Created by aidmed on 31/08/2021.
//

import Foundation
import UIKit

class RegisterViewController: UIViewController {
    
    
    private let service = LoginService()
    
    private let image = UIImageView()
    private let label = UILabel()
    private let usernameTextField = UITextField()
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let registerButton = UIButton()
    
    static func loadFromStoryboard() -> RegisterViewController? {
        let storyboard = UIStoryboard(name: "RegisterView", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "RegisterView") as? RegisterViewController
    }
    
    override func viewDidLoad() {
        // from SGSwiftExtensions
        hideKeyboardWhenTappedOutside()
        setupBackground()
        addIcon()
        addHelloText()
        addTextFields()
        addRegisterButton()
        addLoginText()
    }
    
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
    
    private func addTextFields() {
        view.addSubview(usernameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        
        usernameTextField.defaultStyle(placeholder: "Username")
        emailTextField.defaultStyle(placeholder: "Email")
        passwordTextField.defaultStyle(placeholder: "Password")
 
        usernameTextField.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(label.snp.bottom).offset(39)
            make.right.left.equalTo(view).inset(34)
            make.height.equalTo(49)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(usernameTextField.snp.bottom).offset(21)
            make.right.left.equalTo(view).inset(34)
            make.height.equalTo(49)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(emailTextField.snp.bottom).offset(21)
            make.right.left.equalTo(view).inset(34)
            make.height.equalTo(49)
        }
        
        
    }
    
    private func addRegisterButton() {
        view.addSubview(registerButton)
        
        registerButton.defaultStyle(title: "Register")

        registerButton.addTarget(self, action: #selector(didPressRegisterButton), for: .touchUpInside)
        
        registerButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(passwordTextField.snp.bottom).offset(21)
            make.right.left.equalTo(view).inset(34)
            make.height.equalTo(49)
        }
    }
    
    private func addLoginText() {
        let forgotPasswordView = TextWithButton()
        forgotPasswordView.create(
            labelText: "Already have an account?", buttonText: "Login", onTap: { [self] in self.navigateToLogin() })
        view.addSubview(forgotPasswordView)
        forgotPasswordView.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(registerButton.snp.bottom).offset(20)
        
        }
    }
    
    private func navigateToLogin() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @objc func didPressRegisterButton() {
        
        guard let username = usernameTextField.text, !username.isEmpty else {
            Toast.shared.presentToast("Please enter username")
            return
        }
        
        guard let email = emailTextField.text, !email.isEmpty else {
            Toast.shared.presentToast("Please enter email")
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            Toast.shared.presentToast("Please enter password")
            return
        }
        
        service.register(username: username, email: email, password: password, completion: { result in
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
