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
}
