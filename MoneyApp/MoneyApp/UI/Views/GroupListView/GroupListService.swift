//
//  GroupListService.swift
//  MoneyApp
//
//  Created by Szymon Gęsicki on 21/08/2021.
//

import Foundation

enum MoneyAppIcon: Int, CaseIterable {
    case hamburger = 1
    case beerHamburger = 2
    case bowl = 3
    case drinks = 4
    case coffee = 5
    case beers = 6
    case kite = 7
    
    func icon() -> String {
        switch self {
        case .hamburger: return "Burgers"
        case .beerHamburger: return "BurgerSet"
        case .bowl: return "Bowling"
        case .drinks: return "Wine"
        case .coffee: return "Cups"
        case .beers: return "Beers"
        case .kite: return "Kite"
        }
    }
    
    static func from(id: Int) -> MoneyAppIcon {
        return MoneyAppIcon.init(rawValue: id) ?? .hamburger
    }
    
    static func randomElement() -> MoneyAppIcon {
        return allCases[(0..<allCases.count).randomElement() ?? 0]
    }
}

class GroupListService {
    
    static let shared = GroupListService()
    
    func fetchGroups(completion: @escaping (([Group]) -> Void)) {

        GroupRepository.shared.fetchGroups(completion: { result in
            switch result {
            case .success(let groups):
                completion(groups.map { Group(id: $0.pk, name: $0.name, totalCost: $0.total_cost, userBalance: $0.user_balance, icon: MoneyAppIcon.from(id: $0.icon), createDate: Date.fromISO(stringDate: $0.create_date), isFavourite: $0.is_favourite, members: $0.members.map {
                    User(pk: $0.user.pk, name: $0.user.username, email: $0.user.email, balance: $0.balance)
                })})
            case .failure(let error):
                print("error \(error.localizedDescription)")
                Toast.shared.presentToast("\(error.localizedDescription)")
                completion([])
            }
        })
    }
    
    func joinGroup(code: String, completion: @escaping ((String) -> Void)) {

        GroupRepository.shared.joinGroup(code: code, completion: { result in
            switch result {
            case .success:
                completion("Success! You joined a new group")
            case .failure(let error):
                print("error \(error.localizedDescription)")
                completion(error.localizedDescription)
            }
        })
    }
    
    func markAsFavourite(group: Group, completion: @escaping ((Bool) -> Void)) {
        GroupRepository.shared.editGroup(group: group, completion: { result in
            completion(result)
        })
    }
}
