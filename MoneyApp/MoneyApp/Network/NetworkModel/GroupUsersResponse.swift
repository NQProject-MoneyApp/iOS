//
//  GroupUsersResponse.swift
//  MoneyApp
//
//  Created by Danielle Saldanha on 05/09/2021.
//

import Foundation

class GroupUsersResponse: Codable {
    let user: UserResponse
    let balance: Double
}
