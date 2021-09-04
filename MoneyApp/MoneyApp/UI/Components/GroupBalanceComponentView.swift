//
//  GroupBalanceComponentView.swift
//  MoneyApp
//
//  Created by Danielle Saldanha on 04/09/2021.
//

import Foundation
import UIKit

class GroupBalanceComponentView: UIView {
    
    func create(user: String, attribute: String, color: UIColor) {
        let userLabel = createLabel(text: user, color: color)
        let attributeLabel = createLabel(text: attribute, color: color)
        
        addSubview(userLabel)
        addSubview(attributeLabel)
        
        userLabel.snp.makeConstraints { make in
            make.left.equalTo(snp.left).offset(16)
            make.top.equalTo(snp.top)
            make.bottom.equalTo(snp.bottom)
        }
        
        attributeLabel.snp.makeConstraints { make in
            make.right.equalTo(snp.right).offset(-16)
        }
    }
    
    func createLabel(text: String, color: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = color
        return label
    }
}
