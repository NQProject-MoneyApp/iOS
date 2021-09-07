//
//  AllExpensesService.swift
//  MoneyApp
//
//  Created by Szymon Gęsicki on 07/09/2021.
//

import Foundation

class AllExpensesService {
    
    
    func fetchExpenses(groupID: Int, completion: @escaping(([Expense]) -> Void)) {
        GroupRepository.shared.fetchExpenses(groupdId: groupID, completion: { result in
            
            switch result {
            case .success(let expense):
                completion(expense.map { Expense(name: $0.name, amount: $0.amount, participants: $0.participants.map { $0.pk })})
            case .failure(let error):
                print("error \(error.localizedDescription)")
                Toast.shared.presentToast("\(error.localizedDescription)")
                completion([])
            }
        })
    }
}
