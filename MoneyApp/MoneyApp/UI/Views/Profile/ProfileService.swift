//
//  ProfileService.swift
//  MoneyApp
//
//  Created by Szymon Gęsicki on 05/09/2021.
//

import Foundation


class ProfileService {
    
    func fetchUser(completion: @escaping ((User?) -> Void)) {
        UserRepository.shared.fetchUser(completion: { result in
            switch result {
            case .success(let user):
                completion(User(pk: user.pk, name: user.username, email: user.email, balance: 0))
            case .failure(let error):
                print("error \(error.localizedDescription)")
                completion(nil)
            }
        })
    }
}
