//
//  AddExpenseService.swift
//  MoneyApp
//
//  Created by Milosz on 05/09/2021.
//

import Foundation

class ExpenseService {
    
    func addExpense(groupId: Int, expense: Expense, completion: @escaping((Bool) -> Void)) {
        GroupRepository.shared.addExpense(groupId: groupId, expense: expense, completion: { result in
            completion(result)
        })
    }
    
    func editExpense(groupId: Int, expense: Expense, completion: @escaping((Bool) -> Void)) {
        GroupRepository.shared.editExpense(groupId: groupId, expense: expense, completion: { result in
            completion(result)
        })
    }
    
    func deleteExpense(groupId: Int, expenseId: Int, completion: @escaping((Bool) -> Void)) {
        GroupRepository.shared.deleteExpense(groupId: groupId, expenseId: expenseId, completion: { result in
            completion(result)
        })
    }
    
    func fetchExpense(groupId: Int, expenseId: Int, completion: @escaping((Expense?) -> Void)) {
        GroupRepository.shared.fetchExpense(groupId: groupId, expenseId: expenseId, completion: { result in
            
            switch result {
            case .success(let expense):
                completion(expense.mapToExpense())
            case .failure(let error):
                print("error \(error.localizedDescription)")
                Toast.shared.presentToast("\(error.localizedDescription)")
                completion(nil)
            }
        })
    }
}
