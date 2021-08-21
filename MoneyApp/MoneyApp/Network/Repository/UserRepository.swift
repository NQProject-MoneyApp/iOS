//
//  UserRepository.swift
//  MoneyApp
//
//  Created by Szymon Gęsicki on 19/08/2021.
//

import Foundation

// todo find better place and better name
struct CustomError: Error {

    var errorDescription: String? { return _description }
    var failureReason: String? { return _description }
    var localizedDescription: String { return _description }

    private var _description: String

    init(description: String) {
        self._description = description
    }
}

class UserRepository {
    
    static let shared = UserRepository()
    
    func login(username: String, password: String, completion: @escaping((Result<String?, CustomError>) -> Void)) {
                
        _ = defaultRequest(api: .login(username: username, password: password)) { result in

            if case let .success(response) = result {

                if 200 ... 299 ~= response.statusCode {

                    do {

                        let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: response.data)
                        completion(.success(loginResponse.key))

                    } catch let error {
                        print("error while decoding \(error.localizedDescription)")
                        completion(.failure(CustomError(description: error.localizedDescription)))
                    }
                } else {
                    print("UserRepository.login error: \(String(decoding: response.data, as: UTF8.self))")
                    completion(.failure(CustomError(description: "Error check credentials")))
                }

            } else if case let .failure(error) = result {
                print("error \(error.localizedDescription)")
                completion(.failure(CustomError(description: error.localizedDescription)))
            }
        }
    }
}
