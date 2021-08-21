//
//  GroupRepository.swift
//  MoneyApp
//
//  Created by Szymon Gęsicki on 21/08/2021.
//

import Foundation

class GroupRepository {
    
    static let shared = GroupRepository()
    
    func fetchGroup(completion: @escaping((Result<[GroupResponse], CustomError>) -> Void)) {
                
        _ = defaultRequest(api: .groups) { result in

            if case let .success(response) = result {

                if 200 ... 299 ~= response.statusCode {

                    do {

                        let groups = try JSONDecoder().decode([GroupResponse].self, from: response.data)
                        completion(.success(groups))

                    } catch let error {
                        print("error while decoding \(error.localizedDescription)")
                        completion(.failure(CustomError(description: error.localizedDescription)))
                    }
                } else {
                    print("GroupRepository.fetch groups error: \(String(decoding: response.data, as: UTF8.self))")
                    completion(.failure(CustomError(description: "Error check credentials")))
                }

            } else if case let .failure(error) = result {
                print("error \(error.localizedDescription)")
                completion(.failure(CustomError(description: error.localizedDescription)))
            }
        }
    }
}
