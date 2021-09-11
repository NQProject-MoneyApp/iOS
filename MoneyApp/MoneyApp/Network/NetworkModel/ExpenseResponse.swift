//
//  File.swift
//  MoneyApp
//
//  Created by Szymon Gęsicki on 07/09/2021.
//

import Foundation

class ExpenseResponse: Codable {
    let pk: Int
    let group_id: Int
    let name: String
    let author: UserResponse
    let amount: Double
    let create_date: String
    let participants: [UserResponse]
    
    func mapToExpense() -> Expense {
        return Expense(id: pk, name: name, amount: amount, participants: participants.map { $0.pk }, author: User(pk: author.pk, name: author.username, email: author.email, balance: 0), createDate: Date.fromISO(stringDate: create_date))
    }
}
