//
//  Button.swift
//  MoneyApp
//
//  Created by Milosz on 04/09/2021.
//

import Foundation
import UIKit

extension UIButton {
    
    func defaultStyle(title: String) {
        setTitle(title, for: .normal)
        backgroundColor = UIColor.brand.yellow
        setTitleColor(UIColor.black, for: .normal)
        layer.cornerRadius = 10.0
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        
        snp.makeConstraints { make in
            make.height.equalTo(49)
        }
    }
}
