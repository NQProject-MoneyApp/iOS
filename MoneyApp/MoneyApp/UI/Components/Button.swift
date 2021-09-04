//
//  Button.swift
//  MoneyApp
//
//  Created by aidmed on 04/09/2021.
//

import Foundation
import UIKit

extension UIButton {
    
    func defaultStyle(title: String) {
        setTitle(title, for: .normal)
        backgroundColor = UIColor.brand.yellow
        setTitleColor(UIColor.black, for: .normal)
        layer.cornerRadius = 10.0
    }
    
}
