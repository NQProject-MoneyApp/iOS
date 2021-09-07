//
//  GroupDetailsService.swift
//  MoneyApp
//
//  Created by Szymon Gęsicki on 07/09/2021.
//

import Foundation


class GroupDetailsService {
    
    func code(groupId: Int, completion: @escaping((Result<(String), CustomError>) -> Void)) {
        GroupRepository.shared.code(groupId: groupId, completion: { result in
            completion(result)
        })
    }
}
