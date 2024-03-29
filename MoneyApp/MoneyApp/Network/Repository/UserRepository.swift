//
//  UserRepository.swift
//  MoneyApp
//
//  Created by Szymon Gęsicki on 19/08/2021.
//

import Foundation

class UserRepository {
    
    static let shared = UserRepository()
    
    func login(username: String, password: String, completion: @escaping((Result<String?, MoneyAppError>) -> Void)) {
                
        _ = defaultRequest(api: .login(username: username, password: password)) { result in

            if case let .success(response) = result {

                if 200 ... 299 ~= response.statusCode {

                    do {

                        let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: response.data)
                        completion(.success(loginResponse.key))

                    } catch let error {
                        print("error while decoding \(error.localizedDescription)")
                        completion(.failure(MoneyAppError(description: error.localizedDescription)))
                    }
                } else {
                    print("UserRepository.login error: \(String(decoding: response.data, as: UTF8.self))")
                    completion(.failure(MoneyAppError(description: "Error check credentials")))
                }

            } else if case let .failure(error) = result {
                print("error \(error.localizedDescription)")
                completion(.failure(MoneyAppError(description: error.localizedDescription)))
            }
        }
    }
    
    func register(username: String, email: String, password: String, completion: @escaping((Result<String?, MoneyAppError>) -> Void)) {
                
        _ = defaultRequest(api: .register(username: username, email: email, password: password)) { result in

            if case let .success(response) = result {

                if 200 ... 299 ~= response.statusCode {

                    do {

                        let registerResponse = try JSONDecoder().decode(RegisterResponse.self, from: response.data)
                        completion(.success(registerResponse.key))

                    } catch let error {
                        print("error while decoding \(error.localizedDescription)")
                        completion(.failure(MoneyAppError(description: error.localizedDescription)))
                    }
                } else {
                    print("UserRepository.login error: \(String(decoding: response.data, as: UTF8.self))")
                    completion(.failure(MoneyAppError(description: "Failed to register")))
                }

            } else if case let .failure(error) = result {
                print("error \(error.localizedDescription)")
                completion(.failure(MoneyAppError(description: error.localizedDescription)))
            }
        }
    }
    
    func fetchUser(completion: @escaping((Result<UserResponse, MoneyAppError>) -> Void)) {
                
        _ = defaultRequest(api: .fetchUser) { result in

            if case let .success(response) = result {

                if 200 ... 299 ~= response.statusCode {

                    do {

                        let user = try JSONDecoder().decode(UserResponse.self, from: response.data)
                        completion(.success(user))

                    } catch let error {
                        print("error while decoding \(error.localizedDescription)")
                        completion(.failure(MoneyAppError(description: error.localizedDescription)))
                    }
                } else {
                    print("UserRepository.fetchUser error: \(String(decoding: response.data, as: UTF8.self))")
                    completion(.failure(MoneyAppError(description: "error")))
                }

            } else if case let .failure(error) = result {
                print("error \(error.localizedDescription)")
                completion(.failure(MoneyAppError(description: error.localizedDescription)))
            }
        }
    }
    
    func updateUser(user: User, completion: @escaping((Result<UserResponse, MoneyAppError>) -> Void)) {

        _ = defaultRequest(api: .updateUser(user: user)) { result in

            if case let .success(response) = result {

                if 200 ... 299 ~= response.statusCode {

                    do {
                        let user = try JSONDecoder().decode(UserResponse.self, from: response.data)
                        completion(.success(user))

                    } catch let error {
                        print("error while decoding \(error.localizedDescription)")
                        completion(.failure(MoneyAppError(description: error.localizedDescription)))
                    }
                } else {
                    print("UserRepository.updateUser error: \(String(decoding: response.data, as: UTF8.self))")
                    completion(.failure(MoneyAppError(description: "error")))
                }

            } else if case let .failure(error) = result {
                print("error \(error.localizedDescription)")
                completion(.failure(MoneyAppError(description: error.localizedDescription)))
            }
        }
    }
}
