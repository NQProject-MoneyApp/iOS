//
//  GroupDetailsService.swift
//  MoneyApp
//
//  Created by Danielle Saldanha on 04/09/2021.
//

import Foundation

class GroupDetailsService {

    static let shared = GroupDetailsService()

    func fetchGroupDetails(group: Group, completion: @escaping ((Group) -> Void)) {
        GroupRepository.shared.fetchGroupDetails(groupId: group.id, completion: {
            result in

            switch result {
            case .success(let groupDetails):
                completion(group)
            case .failure(let error):
                print("error \(error.localizedDescription)")
                Toast.shared.presentToast("\(error.localizedDescription)")
                completion(group)
            }

        })

    }
}
