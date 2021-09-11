//
//  GroupDetailsService.swift
//  MoneyApp
//
//  Created by Szymon Gęsicki on 07/09/2021.
//

import Foundation

class GroupDetailsService {
    
    func code(groupId: Int, completion: @escaping((Result<(String), MoneyAppError>) -> Void)) {
        GroupRepository.shared.code(groupId: groupId, completion: { result in
            completion(result)
        })
    }
    
    func fetchGroupDetails(groupId: Int, completion: @escaping(Group?) -> Void) {
        
        GroupRepository.shared.fetchGroupDetails(groupId: groupId, completion: { result in
            switch result {
            case .success(let group):
                completion(Group(id: group.pk, name: group.name, totalCost: group.total_cost, userBalance: group.user_balance, icon: MoneyAppIcon.from(id: group.icon), createDate: Date.fromISO(stringDate: group.create_date), isFavourite: group.is_favourite, members: group.members.map {
                    User(pk: $0.user.pk, name: $0.user.username, email: $0.user.email, balance: $0.balance)
                }))
                
            case .failure(let error):
                print("error \(error.localizedDescription)")
                Toast.shared.presentToast("\(error.localizedDescription)")
                completion(nil)
            }
        })
    }
}
