//
//  ExpenseComponent.swift
//  MoneyApp
//
//  Created by Szymon Gęsicki on 07/09/2021.
//

import Foundation
import UIKit

protocol ExpenseComponentDelegate: AnyObject {
    func didPressExpenseComponent(expense: Expense)
}

class ExpenseComponent: UIView {
    
    private var expense: Expense?
    private weak var delegate: ExpenseComponentDelegate?
    
    func create(expense: Expense, delegate: ExpenseComponentDelegate) {
        self.expense = expense
        self.delegate = delegate
        setupView()
        
        let nameLabel = createLabel(text: expense.name, color: UIColor.brand.yellow, size: 22)
        let authorLabel = createLabel(text: expense.author.name, color: UIColor.white, size: 15)
        let amountLabel = createLabel(text: "\(expense.amount.format(".2"))", color: UIColor.white, size: 15)
        
        addSubview(nameLabel)
        addSubview(authorLabel)
        addSubview(amountLabel)
        
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
        
        amountLabel.snp.makeConstraints { make in
            make.right.equalTo(snp.right).offset(-16)
            make.bottom.equalTo(snp.bottom).offset(-16)
        }
    }
    
    private func setupView() {
        backgroundColor = UIColor.brand.gray
        layer.cornerRadius = 15
        
        addTapGesture(tapNumber: 1, target: self, action: #selector(didPressView))
    }
    
    @objc func didPressView() {
        guard let expense = expense else { return }
        delegate?.didPressExpenseComponent(expense: expense)
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
