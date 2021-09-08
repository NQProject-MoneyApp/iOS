//
//  ExpenseComponent.swift
//  MoneyApp
//
//  Created by Szymon Gęsicki on 07/09/2021.
//

import Foundation
import UIKit

class ExpenseComponent: UIView {
    
    func create(expense: Expense) {
        backgroundColor = UIColor.brand.gray
        layer.cornerRadius = 15
        
        let nameLabel = createLabel(text: expense.name, color: UIColor.brand.yellow, size: 22)
        let authorLabel = createLabel(text: expense.author.name, color: UIColor.white, size: 15)
        let amoutLabel = createLabel(text: "\(expense.amount.format(".2"))", color: UIColor.white, size: 15)
        
        addSubview(nameLabel)
        addSubview(authorLabel)
        addSubview(amoutLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(16)
            make.left.equalTo(snp.left).offset(16)
            make.right.equalTo(snp.right).offset(-16)

        }
        
        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(16)
            make.left.equalTo(snp.left).offset(16)
            make.bottom.equalTo(snp.bottom).offset(-16)

        }
        
        amoutLabel.snp.makeConstraints { make in
            make.right.equalTo(snp.right).offset(-16)
            make.bottom.equalTo(snp.bottom).offset(-16)
        }
    }
    
    private func createLabel(text: String, color: UIColor, size: CGFloat) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = color
        label.font = UIFont.systemFont(ofSize: size)
        label.numberOfLines = 2
        
        return label
    }

}
