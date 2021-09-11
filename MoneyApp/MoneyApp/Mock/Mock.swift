//
//  Mock.swift
//  MoneyApp
//
//  Created by Szymon Gęsicki on 21/08/2021.
//

import Foundation

class Mock {
    static let shared = Mock()
    
    func fetchGroups() -> [Group] {

        return [
            Group(id: 0, name: "Coffee at Starbucks ", totalCost: 123, userBalance: 12, icon: .hamburger, createDate: Date(), isFavourite: true, members: []),
            Group(id: 0, name: "Burger with Julia", totalCost: 123, userBalance: -12.44, icon: .beers, createDate: Date(), isFavourite: true, members: []),
            Group(id: 0, name: "My birthday", totalCost: 123, userBalance: 12, icon: .bowl, createDate: Date(), isFavourite: false, members: []),
            Group(id: 0, name: "Coffe long coffe long long long", totalCost: 123, userBalance: -12, icon: .coffee, createDate: Date(), isFavourite: false, members: []),
            Group(id: 0, name: "Burger", totalCost: 123, userBalance: 12, icon: .drinks, createDate: Date(), isFavourite: false, members: []),
            Group(id: 0, name: "Birthday", totalCost: 123, userBalance: 12.1234, icon: .beerHamburger, createDate: Date(), isFavourite: false, members: [])
        ]
    }
    
    func fetchUserBalances() -> [User] {
        return [
            User(pk: 0, name: "Miłosz", email: "milosz@gmail.com", balance: -300),
            User(pk: 1, name: "Szymon", email: "szym@gmail.com", balance: -100),
            User(pk: 2, name: "Speerit", email: "speerit@gmail.com", balance: 5),
            User(pk: 3, name: "Danielle", email: "dan@gmail.com", balance: -20)
        ]
    }
    
    func fetchUserData() -> User {
        return User(pk: 0, name: "Miłosz", email: "milosz@gmail.com", balance: -300)
    }
}
