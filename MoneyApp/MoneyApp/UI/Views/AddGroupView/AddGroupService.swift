//
//  AddGroupService.swift
//  MoneyApp
//
//  Created by Szymon Gęsicki on 04/09/2021.
//

import Foundation

class AddGroupService {
    
    static let shared = AddGroupService()
    
    func addGroup(name: String, icon: MoneyAppIcon, members: [Int], completion: @escaping ((Bool) -> Void)) {

        GroupRepository.shared.addGroup(name: name, icon: icon.rawValue, members: members, completion: { result in
            switch result {
            case .success:
                completion(true)
            case .failure(let error):
                print("error \(error.localizedDescription)")
                Toast.shared.presentToast("\(error.localizedDescription)")
                completion(false)
            }
        })
    }
    
    func editGroup(group: Group, completion: @escaping ((Bool) -> Void)) {
        GroupRepository.shared.editGroup(group: group, completion: { result in
            completion(result)
        })
    }
    
    func fetchFriends(completion: @escaping (([User]) -> Void)) {
        GroupRepository.shared.friends(completion: { result in
            switch result {
            case .success(let friends):
                completion(friends.map { User(pk: $0.pk, name: $0.username, email: $0.email, balance: 0) })
            case .failure(let error):
                print("error \(error.localizedDescription)")
                Toast.shared.presentToast("\(error.localizedDescription)")
                completion([])
            }
        })
    }
}
