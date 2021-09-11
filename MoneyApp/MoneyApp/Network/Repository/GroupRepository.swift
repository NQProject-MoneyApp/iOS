//
//  GroupRepository.swift
//  MoneyApp
//
//  Created by Szymon Gęsicki on 21/08/2021.
//

import Foundation

class GroupRepository {
    
    static let shared = GroupRepository()
    
    func fetchGroups(completion: @escaping((Result<[GroupResponse], CustomError>) -> Void)) {
                
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
    
    func fetchGroupDetails(groupId: Int, completion: @escaping((Result<GroupResponse, CustomError>) -> Void)) {
        _ = defaultRequest(api: .groupDetails(groupId: groupId)) { result in

            if case let .success(response) = result {

                if 200 ... 299 ~= response.statusCode {

                    do {

                        let groupDetails = try JSONDecoder().decode(GroupResponse.self, from: response.data)
                        completion(.success(groupDetails))

                    } catch let error {
                        print("error while decoding \(error.localizedDescription)")
                        completion(.failure(CustomError(description: error.localizedDescription)))
                    }
                } else {
                    print("GroupRepository.fetch group details error: \(String(decoding: response.data, as: UTF8.self))")
                    completion(.failure(CustomError(description: "group details fetch error")))
                }

            } else if case let .failure(error) = result {
                print("error \(error.localizedDescription)")
                completion(.failure(CustomError(description: error.localizedDescription)))
            }
        }
    }
    
    func joinGroup(code: String, completion: @escaping((Result<(Void), CustomError>) -> Void)) {
                
        _ = defaultRequest(api: .joinGroup(code: code)) { result in

            if case let .success(response) = result {

                if 200 ... 299 ~= response.statusCode {
                    completion(.success(()))
                } else {
                    
                    do {
                        let joinResponse = try JSONDecoder().decode(JoinResponse.self, from: response.data)
                        completion(.failure(CustomError(description: joinResponse.details)))
                    } catch let error {
                        print("error while decoding \(error.localizedDescription) \nData: \(String(data: response.data, encoding: .utf8) ?? "")")
                        completion(.failure(CustomError(description: "Unknown error")))
                    }
                }
            } else if case let .failure(error) = result {
                print("error \(error.localizedDescription)")
                completion(.failure(CustomError(description: error.localizedDescription)))
            }
        }
    }
    
    func editGroup(group: Group, completion: @escaping((Bool) -> Void)) {
        _ = defaultRequest(api: .editGroup(group: group)) { result in
            
            if case let .success(response) = result, 200 ... 299 ~= response.statusCode {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func addExpense(groupId: Int, expense: Expense, completion: @escaping((Bool) -> Void)) {
        
        _ = defaultRequest(api: .newExpense(groupId: groupId, expense: expense), completion: { result in
            
            if case let .success(response) = result, 200 ... 299 ~= response.statusCode {
                completion(true)
            } else {
                completion(false)
            }
        })
    }
    
    func editExpense(groupId: Int, expense: Expense, completion: @escaping((Bool) -> Void)) {
        
        _ = defaultRequest(api: .editExpense(groupId: groupId, expense: expense), completion: { result in
            
            if case let .success(response) = result, 200 ... 299 ~= response.statusCode {
                completion(true)
            } else {
                completion(false)
            }
        })
    }
    
    func deleteExpense(groupId: Int, expenseId: Int, completion: @escaping((Bool) -> Void)) {
        
        _ = defaultRequest(api: .deleteExpense(groupId: groupId, expenseId: expenseId), completion: { result in
            
            if case let .success(response) = result, 200 ... 299 ~= response.statusCode {
                
                completion(true)
            } else {
                completion(false)
            }
        })
    }
    
    func fetchExpense(groupId: Int, expenseId: Int, completion: @escaping((Result<ExpenseResponse, CustomError>) -> Void)) {
        _ = defaultRequest(api: .fetchExpense(groupId: groupId, expenseId: expenseId)) { result in

            if case let .success(response) = result {

                if 200 ... 299 ~= response.statusCode {

                    do {

                        let expense = try JSONDecoder().decode(ExpenseResponse.self, from: response.data)
                        completion(.success(expense))

                    } catch let error {
                        print("error while decoding \(error.localizedDescription)")
                        completion(.failure(CustomError(description: error.localizedDescription)))
                    }
                } else {
                    print("GroupRepository.fetch expense error: \(String(decoding: response.data, as: UTF8.self))")
                    completion(.failure(CustomError(description: "group details fetch error")))
                }

            } else if case let .failure(error) = result {
                print("error \(error.localizedDescription)")
                completion(.failure(CustomError(description: error.localizedDescription)))
            }
        }
    }
    
    func code(groupId: Int, completion: @escaping((Result<(String), CustomError>) -> Void)) {
        
        _ = defaultRequest(api: .code(groupdId: groupId)) { result in

            if case let .success(response) = result {

                if 200 ... 299 ~= response.statusCode {
                    
                    do {
                        let code = try JSONDecoder().decode(CodeResponse.self, from: response.data)
                        completion(.success(code.code))
                        
                    } catch let error {
                        print("error while decoding \(error.localizedDescription) \nData: \(String(data: response.data, encoding: .utf8) ?? "")")
                        completion(.failure(CustomError(description: "Unknown error")))
                    }

                } else {
                    completion(.failure(CustomError(description: "Unknown error")))
                }
            } else if case let .failure(error) = result {
                print("error \(error.localizedDescription)")
                completion(.failure(CustomError(description: error.localizedDescription)))
            }
        }
    }
    
    func fetchExpenses(groupdId: Int, completion: @escaping((Result<[ExpenseResponse], CustomError>) -> Void)) {
                
        _ = defaultRequest(api: .expenses(groupdId: groupdId)) { result in

            if case let .success(response) = result {

                if 200 ... 299 ~= response.statusCode {

                    do {

                        let expenses = try JSONDecoder().decode([ExpenseResponse].self, from: response.data)
                        completion(.success(expenses))

                    } catch let error {
                        print("error while decoding \(error.localizedDescription)")
                        completion(.failure(CustomError(description: error.localizedDescription)))
                    }
                } else {
                    print("GroupRepository.fetch expenses error: \(String(decoding: response.data, as: UTF8.self))")
                    completion(.failure(CustomError(description: "Error check credentials")))
                }

            } else if case let .failure(error) = result {
                print("error \(error.localizedDescription)")
                completion(.failure(CustomError(description: error.localizedDescription)))
            }
        }
    }
    
    func friends(completion: @escaping((Result<[UserResponse], CustomError>) -> Void)) {
                
        _ = defaultRequest(api: .friends) { result in

            if case let .success(response) = result {

                if 200 ... 299 ~= response.statusCode {

                    do {

                        let friends = try JSONDecoder().decode([UserResponse].self, from: response.data)
                        completion(.success(friends))

                    } catch let error {
                        print("error while decoding \(error.localizedDescription)")
                        completion(.failure(CustomError(description: error.localizedDescription)))
                    }
                } else {
                    print("GroupRepository.fetch friends error: \(String(decoding: response.data, as: UTF8.self))")
                    completion(.failure(CustomError(description: "Error check credentials")))
                }

            } else if case let .failure(error) = result {
                print("error \(error.localizedDescription)")
                completion(.failure(CustomError(description: error.localizedDescription)))
            }
        }
    }
    
    func addGroup(name: String, icon: Int, members: [Int], completion: @escaping((Result<Bool, CustomError>) -> Void)) {

        _ = defaultRequest(api: .addGroup(name: name, icon: icon, members: members)) { result in

            if case let .success(response) = result, 200 ... 299 ~= response.statusCode {
                completion(.success(true))

            } else if case let .failure(error) = result {
                print("error \(error.localizedDescription)")
                completion(.failure(CustomError(description: error.localizedDescription)))
            }
        }
    }
 }
