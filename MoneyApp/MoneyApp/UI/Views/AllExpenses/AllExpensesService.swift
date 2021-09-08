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
                completion(expense.map { Expense(name: $0.name, amount: $0.amount, participants: $0.participants.map { $0.pk }, author: User(pk: $0.author.pk, name: $0.author.username, email: $0.author.email, balance: 0))})
            case .failure(let error):
                print("error \(error.localizedDescription)")
                Toast.shared.presentToast("\(error.localizedDescription)")
                completion([])
            }
        })
    }
}
