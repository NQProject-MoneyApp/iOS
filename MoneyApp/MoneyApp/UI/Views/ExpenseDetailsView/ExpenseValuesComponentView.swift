//
//  ExpenseValuesComponentView.swift
//  MoneyApp
//
//  Created by Danielle Saldanha on 11/09/2021.
//

import Foundation
import UIKit

class ExpenseValuesComponentView: UIView {
    
    private var expense: Expense?
    
    func create(expense: Expense) {
        self.expense = expense
        
        let amountLabel = createTextLabel(text: "Amount")
        let amount = createNumericLabel(amount: expense.amount)
        let paidLabel = createTextLabel(text: "Paid")
        let paid = createTextLabel(text: expense.author.name)
        
        addSubview(amountLabel)
        addSubview(amount)
        addSubview(paidLabel)
        addSubview(paid)
        
        amountLabel.snp.makeConstraints { make in
            make.left.equalTo(snp.left)
            make.top.equalTo(snp.top)
        }
        
        amount.snp.makeConstraints { make in
            make.right.equalTo(snp.right)
            make.top.equalTo(amountLabel.snp.top)
        }
        
        paidLabel.snp.makeConstraints { make in
            make.left.equalTo(snp.left)
            make.top.equalTo(amount.snp.bottom).offset(8)
        }
        
        paid.snp.makeConstraints { make in
            make.right.equalTo(snp.right)
            make.top.equalTo(paidLabel.snp.top)
            make.bottom.equalTo(snp.bottom)
        }
    }
    
    private func createTextLabel(text: String) -> UILabel {
        let textLabel = UILabel()
        textLabel.text = text
        textLabel.textColor = UIColor.white
        textLabel.font = UIFont.boldSystemFont(ofSize: 24)
        
        return textLabel
    }
    
    private func createNumericLabel(amount: Double) -> UILabel {
        let numericLabel = UILabel()
        numericLabel.text = "$ \(amount.format(".2"))"
        numericLabel.textColor = UIColor.white
        numericLabel.font = UIFont.boldSystemFont(ofSize: 24)
        
        return numericLabel
    }
}
