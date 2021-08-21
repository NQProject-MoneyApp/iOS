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
            Group(id: 0, name: "Coffe at Sturbucks ", totalCost: 123, userBalance: 12, icon: "coffee", createDate: Date(), isFavourite: true),
            Group(id: 0, name: "Burger with Julia", totalCost: 123, userBalance: -12.44, icon: "coffee", createDate: Date(), isFavourite: true),
            Group(id: 0, name: "My birthday", totalCost: 123, userBalance: 12, icon: "coffee", createDate: Date(), isFavourite: false),
            Group(id: 0, name: "Coffe long coffe long long long", totalCost: 123, userBalance: -12, icon: "coffee", createDate: Date(), isFavourite: false),
            Group(id: 0, name: "Burger", totalCost: 123, userBalance: 12, icon: "coffee", createDate: Date(), isFavourite: false),
            Group(id: 0, name: "Birthday", totalCost: 123, userBalance: 12.1234, icon: "coffee", createDate: Date(), isFavourite: false)]
    }
}
