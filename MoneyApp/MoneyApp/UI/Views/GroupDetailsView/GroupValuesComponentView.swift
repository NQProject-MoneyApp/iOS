//
//  GroupValuesComponent.swift
//  MoneyApp
//
//  Created by Danielle Saldanha on 04/09/2021.
//

import Foundation
import UIKit

class GroupValuesComponentView: UIView {
    
    private var group: Group?
    
    func create(group: Group) {
        self.group = group
        
        let totalCostLabel = createTitleLabel(text: "Total cost")
        let totalCost = createNumericLabel(amount: group.totalCost)
        let balanceLabel = createTitleLabel(text: "Balance")
        let balance = createNumericLabel(amount: group.userBalance, isBalance: true)
        
        addSubview(totalCostLabel)
        addSubview(totalCost)
        addSubview(balanceLabel)
        addSubview(balance)
        
        totalCostLabel.snp.makeConstraints { make in
            make.left.equalTo(snp.left)
            make.top.equalTo(snp.top)
        }
        
        totalCost.snp.makeConstraints { make in
            make.right.equalTo(snp.right)
            make.top.equalTo(totalCostLabel.snp.top)
        }
        
        balanceLabel.snp.makeConstraints { make in
            make.left.equalTo(snp.left)
            make.top.equalTo(totalCost.snp.bottom).offset(8)
        }
        
        balance.snp.makeConstraints { make in
            make.right.equalTo(snp.right)
            make.top.equalTo(balanceLabel.snp.top)
            make.bottom.equalTo(snp.bottom)
        }
    }
    
    private func createTitleLabel(text: String) -> UILabel {
        let titleLabel = UILabel()
        titleLabel.text = text
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        
        return titleLabel
    }
    
    private func createNumericLabel(amount: Double, isBalance: Bool = false) -> UILabel {
        let numericLabel = UILabel()
        numericLabel.text = "$ \(amount.format(".2"))"
        numericLabel.font = UIFont.boldSystemFont(ofSize: 24)
        
        if isBalance {
            if amount < 0 {
                numericLabel.textColor = UIColor.red
            } else {
                numericLabel.textColor = UIColor.green
            }
        } else {
            numericLabel.textColor = UIColor.white
        }
        
        return numericLabel
    }
}
