//
//  Expense.swift
//  MoneyApp
//
//  Created by aidmed on 05/09/2021.
//

import Foundation

class Expense {
    init(name: String, amount: Double, participants: [Int], author: User) {
        self.name = name
        self.amount = amount
        self.participants = participants
        self.author = author
    }
    
    let name: String
    let amount: Double
    let author: User
    let participants: [Int]
    
}
