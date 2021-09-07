//
//  AddExpenseService.swift
//  MoneyApp
//
//  Created by aidmed on 05/09/2021.
//

import Foundation

class AddExpenseService {
    
    func addExpense(groupId: Int, expense: Expense, completion: @escaping((Bool) -> Void)) {
        GroupRepository.shared.addExpense(groupId: groupId, expense: expense, completion: { result in
            completion(result)
        })
    }
}
