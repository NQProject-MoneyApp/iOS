//
//  Expense.swift
//  MoneyApp
//
//  Created by aidmed on 05/09/2021.
//

import Foundation

class Expense {
    init(name: String, amount: Double, participants: [Int]) {
        self.name = name
        self.amount = amount
        self.participants = participants
    }
    
    let name: String
    let amount: Double
    let participants: [Int]
    
}
