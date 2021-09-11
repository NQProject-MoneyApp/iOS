//
//  JoinAlertController.swift
//  MoneyApp
//
//  Created by Szymon Gęsicki on 11/09/2021.
//

import Foundation
import UIKit

class JoinAlertController: UIAlertController {
    
    static func create(onJoin: @escaping((String?) -> Void)) -> JoinAlertController {
        let alert = JoinAlertController(title: "Enter the code", message: nil, preferredStyle: .alert)
        alert.view.tintColor = UIColor.brand.yellow
        
        alert.addTextField { textField in
            textField.placeholder = "Code"
            textField.tintColor = UIColor.brand.yellow
            textField.addTarget(alert, action: #selector(alert.textChanged), for: .editingChanged)
        }
        
        alert.addAction(UIAlertAction(title: "Back", style: .default, handler: nil))
        
        let joinAction = UIAlertAction(title: "Join", style: .default, handler: { _ in
            onJoin(alert.textFields?.first?.text)
        })
        
        joinAction.isEnabled = false
        alert.addAction(joinAction)
        
        return alert
    }
    
    @objc func textChanged(_ sender: Any) {
        
        if let textField = sender as? UITextField {
            var resp: UIResponder! = textField
            while !(resp is UIAlertController) { resp = resp.next }
            (resp as? UIAlertController)?.actions[1].isEnabled = (textField.text != "")
        }
    }
}
