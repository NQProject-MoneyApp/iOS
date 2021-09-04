//
//  RegisterViewController.swift
//  MoneyApp
//
//  Created by aidmed on 31/08/2021.
//

import Foundation
import UIKit

class RegisterViewController: UIViewController {
    
    static func loadFromStoryboard() -> RegisterViewController? {
        let storyboard = UIStoryboard(name: "RegisterView", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "RegisterView") as? RegisterViewController
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.setBackgroundColor(color: UIColor.black)
//        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    override func viewDidLoad() {
        // from SGSwiftExtensions
        hideKeyboardWhenTappedOutside()
        setupBackground()
        addHelloText()
    }

    
    private func addHelloText() {
        let label = UILabel()
        label.text = "Register"
        label.textColor = UIColor.brand.yellow
        // todo add font
        label.font = UIFont.systemFont(ofSize: 32)
        
        view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(view.snp.top).offset(70)
        }
    }
    
    private func setupBackground() {
        view.backgroundColor = UIColor.black
    }
    
    
}
