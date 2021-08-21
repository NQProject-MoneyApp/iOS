//
//  GroupListService.swift
//  MoneyApp
//
//  Created by Szymon Gęsicki on 21/08/2021.
//

import Foundation

class GroupListService {
    
    func fetchGroups(completion: @escaping (([Group]) -> Void)) {
        // todo completion result!
        GroupRepository.shared.fetchGroup(completion: { result in
            
            switch result {
            case .success(let groups):
                // todo parse icon
                completion(groups.map { Group(id: $0.pk, name: $0.name, totalCost: $0.total_cost, userBalance: $0.user_balance, icon: "coffee", createDate: self.stringToDate(stringDate: $0.create_date), isFavourite: $0.is_favourite)})
            case .failure(let error):
                print("error \(error.localizedDescription)")
                Toast.shared.presentToast("\(error.localizedDescription)")
                completion([])
            }
        })
    }
    
    // todo move to utilities
    private func stringToDate(stringDate: String) -> Date {
        // todo parse date
        return Date()
    }
}
