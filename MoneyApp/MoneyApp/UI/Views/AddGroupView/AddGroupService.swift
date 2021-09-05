//
//  AddGroupService.swift
//  MoneyApp
//
//  Created by Szymon Gęsicki on 04/09/2021.
//

import Foundation

class AddGroupService {
    
    static let shared = AddGroupService()
    
    func addGroup(completion: @escaping ((String) -> Void)) {
        // todo completion result!
        GroupRepository.shared.fetchGroups(completion: { result in
            
            switch result {
            case .success(let _):
                // todo parse icon
                completion("")
            case .failure(let error):
                print("error \(error.localizedDescription)")
                Toast.shared.presentToast("\(error.localizedDescription)")
                completion("")
            }
        })
    }
}
