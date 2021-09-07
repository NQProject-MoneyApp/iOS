//
//  CodeAlertController.swift
//  MoneyApp
//
//  Created by Szymon Gęsicki on 07/09/2021.
//

import Foundation
import UIKit

class CodeAlertController: UIAlertController {
    
    private let activityIndicator = UIActivityIndicatorView()
    private var groupCode: String = ""

    static func initial() -> CodeAlertController {
        
        let alert = CodeAlertController(title: "Share the code with friends!", message: nil, preferredStyle: .alert)
        alert.view.tintColor = UIColor.brand.yellow
        
        let back = UIAlertAction(title: "Back", style: .default, handler: { _ in })
        alert.addAction(back)
        
        alert.appendActivityIndicator()
        
        return alert
    }
    
    func code(code: String) {
        groupCode = code
        
        activityIndicator.fadeTo(0, duration: 0.5, destroyAfter: true, completion: { _ in
            let codeView = self.createCodeView(code: code)
            self.view.addSubview(codeView)
            codeView.alpha = 0

            codeView.snp.makeConstraints { make in
                make.bottom.equalTo(self.view.snp.bottom).offset(-70)
                make.top.equalTo(self.view.snp.top).offset(70)
                make.left.equalTo(self.view.snp.left).offset(16)
                make.right.equalTo(self.view.snp.right).offset(-16)
                make.height.equalTo(40)
            }

            codeView.fadeIn(1)
        })
    }
    
    private func createCodeView(code: String) -> UIView {
        let container = UIView()
        container.backgroundColor = UIColor.brand.gray
        container.layer.borderWidth = 2
        container.layer.borderColor = UIColor.brand.yellow.cgColor
        container.layer.cornerRadius = 15
        container.addTapGesture(tapNumber: 1, target: self, action: #selector(didPressCode))
        
        let label = UILabel()
        label.text = code
        
        container.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.center.equalTo(container.snp.center)
        }
        
        return container

    }
    
    private func appendActivityIndicator() {
        activityIndicator.color = UIColor.brand.yellow
        
        view.addSubview(activityIndicator)
        
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(view.snp.bottom).offset(-70)
            make.top.equalTo(view.snp.top).offset(70)
            make.height.equalTo(40)
        }
        
        activityIndicator.startAnimating()
    }
    
    @objc private func didPressCode() {
        UIPasteboard.general.string = groupCode
        Toast.shared.presentToast("Code copied")
    }
}
