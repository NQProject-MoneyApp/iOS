//
//  User.swift
//  MoneyApp
//
//  Created by Danielle Saldanha on 04/09/2021.
//

import Foundation

class User {
    let pk: Int
    let name: String
    let email: String
    let balance: Double
    
    init(pk: Int, name: String, email: String, balance: Double) {
        self.pk = pk
        self.name = name
        self.email = email
        self.balance = balance
    }
}
