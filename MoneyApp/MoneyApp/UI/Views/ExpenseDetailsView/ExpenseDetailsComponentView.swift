//
//  ExpenseDetailsComponentView.swift
//  MoneyApp
//
//  Created by Danielle Saldanha on 11/09/2021.
//

import Foundation
import UIKit

class ExpenseDetailsComponentView: UIView {
    
    private var expense: Expense?
    
    func create(expense: Expense) {
        self.expense = expense
        
        backgroundColor = UIColor.brand.gray
        layer.cornerRadius = 15
        
        let expenseValuesView = ExpenseValuesComponentView()
        expenseValuesView.create(expense: expense)
        
        addSubview(expenseValuesView)
        
        expenseValuesView.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(24)
            make.bottom.equalTo(snp.bottom).offset(-24)
            make.left.equalTo(snp.left).offset(24)
            make.right.equalTo(snp.right).offset(-24)
        }
    }
}
