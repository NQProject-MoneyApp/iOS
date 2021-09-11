//
//  Expense.swift
//  MoneyApp
//
//  Created by Milosz on 05/09/2021.
//

import Foundation

class Expense {
    init(id: Int, name: String, amount: Double, participants: [Int], author: User) {
        self.id = id
        self.name = name
        self.amount = amount
        self.participants = participants
        self.author = author
    }
    
    let id: Int
    let name: String
    let amount: Double
    let author: User
    let participants: [Int]
    
}
