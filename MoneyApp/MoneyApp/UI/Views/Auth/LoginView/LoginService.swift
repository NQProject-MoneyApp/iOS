//
//  LoginService.swift
//  MoneyApp
//
//  Created by Szymon Gęsicki on 19/08/2021.
//

import Foundation

class LoginService {
    
    func login(username: String, password: String, completion: @escaping ((Result<String, CustomError>) -> Void)) {
        
        UserRepository.shared.login(username: username, password: password) { result in
            
            switch result {
            
            case .success(let token):
                if let token = token {
                    print("TOKEN \(token)")
                    Authentication.shared.setToken(token: token)
                    completion(.success("Success"))
                } else {
                    completion(.failure(CustomError(description: "Key = nil")))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func register(username: String, email: String, password: String, completion: @escaping ((Result<String, CustomError>) -> Void)) {
        
        UserRepository.shared.register(username: username, email: email, password: password) { result in
            
            switch result {
            
            case .success(let token):
                if let token = token {
                    print("TOKEN \(token)")
                    Authentication.shared.setToken(token: token)
                    completion(.success("Success"))
                } else {
                    completion(.failure(CustomError(description: "Key = nil")))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

