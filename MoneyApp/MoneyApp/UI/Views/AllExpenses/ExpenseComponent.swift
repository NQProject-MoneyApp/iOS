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
        snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        backgroundColor = UIColor.brand.gray
        
        let label = UILabel()
        
        label.text = expense.name
        
        addSubview(label)
        
        label.snp.makeConstraints { make in
            make.center.equalTo(snp.center)
        }
    }
}
