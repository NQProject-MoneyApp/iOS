//
//  Group.swift
//  MoneyApp
//
//  Created by Szymon Gęsicki on 21/08/2021.
//

import Foundation


class Group {
    
    let id: Int
    var name: String
    let totalCost: Double
    let userBalance: Double
    var icon: MoneyAppIcon
    let createDate: Date
    var isFavourite: Bool
    // todo
//    val members: List<User>
    
    init(id: Int, name: String, totalCost: Double, userBalance: Double, icon: MoneyAppIcon, createDate: Date, isFavourite: Bool) {
        self.id = id
        self.name = name
        self.totalCost = totalCost
        self.userBalance = userBalance
        self.icon = icon
        self.createDate = createDate
        self.isFavourite = isFavourite
    }
}
