//
//  GroupUsersListComponent.swift
//  MoneyApp
//
//  Created by Danielle Saldanha on 04/09/2021.
//

import Foundation
import UIKit

class GroupUsersListComponentView: UIView {
    
    private var components: [UIView] = []
    private var groupUsers: [User] = []
    
    func create(members: [User]) {
        groupUsers = members
        backgroundColor = UIColor.brand.gray
        layer.cornerRadius = 15
        
        let titleRow = GroupBalanceComponentView()
        titleRow.create(user: "Member", attribute: "Balance", color: UIColor.brand.yellow)
       
        appendRow(row: titleRow, last: false)
        
        for groupUser in groupUsers {
            let row = GroupBalanceComponentView()
            let balanceText = "\(groupUser.balance.format(".2"))"
            row.create(user: groupUser.name, attribute: balanceText, color: UIColor.white)
            appendRow(row: row, last: false)
        }
        
        let allExpensesButton = UIButton()
        setUpAllExpensesButton(button: allExpensesButton)
        appendRow(row: allExpensesButton, last: true)
    }
    
    private func appendRow(row: UIView, last: Bool) {
        addSubview(row)
        
        row.snp.makeConstraints { make in
            if let last = components.last {
                make.top.equalTo(last.snp.bottom).offset(16)
            } else {
                make.top.equalTo(snp.top).offset(16)
            }
            
            make.left.equalTo(snp.left).offset(16)
            make.right.equalTo(snp.right).offset(-16)
            
            if last {
                make.bottom.equalTo(snp.bottom).offset(-16)
            }
            
            components.append(row)
        }
    }
    
    private func setUpAllExpensesButton(button: UIButton) {
        button.setTitle("All expenses", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.setTitleColor(UIColor.brand.yellow, for: .normal)
    }
}
