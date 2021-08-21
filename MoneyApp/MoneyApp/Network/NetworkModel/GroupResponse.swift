//
//  GroupResponse.swift
//  MoneyApp
//
//  Created by Szymon Gęsicki on 21/08/2021.
//

import Foundation

class GroupResponse: Codable {
    let pk: Int
    let name: String
    let create_date: String
    let total_cost: Double
    let user_balance: Double
    let icon: Int
    let is_favourite: Bool
//        TODO
//    val members: List<NetworkGroupUsersResponse>,
//    @SerialName("non_field_errors") val error: String? = null,
}
