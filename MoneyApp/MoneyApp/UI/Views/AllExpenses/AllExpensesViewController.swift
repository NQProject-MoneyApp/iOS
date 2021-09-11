//
//  AllExpensesViewController.swift
//  MoneyApp
//
//  Created by Szymon Gęsicki on 06/09/2021.
//

import Foundation
import UIKit

class AllExpensesViewController: UIViewController, ExpenseComponentDelegate {
    
    func didPressExpenseComponent(expense: Expense) {
        guard let vc = ExpenseDetailsViewController.loadFromStoryboard() else { return }
        vc.expense = expense
        navigationController?.pushViewController(vc, animated: true)
    }
    
    static func loadFromStoryboard() -> AllExpensesViewController? {
        let storyboard = UIStoryboard(name: "AllExpensesView", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "AllExpensesView") as? AllExpensesViewController
    }
    
    private let scrollView = ScrollView()
    private let service = AllExpensesService()
    var group: Group?

    override func viewDidLoad() {
        view.backgroundColor = UIColor.brand.blackBackground
        title = "Expenses"
        
        setupScrollView()
        
        guard let group = group else { return }
        service.fetchExpenses(groupID: group.id, completion: { result in
            
            for (idx, expense) in result.enumerated() {
                print("expense \(expense.name) \(idx == result.count - 1)")
                let expenseComponent = ExpenseComponent()
                expenseComponent.create(expense: expense, delegate: self)
                self.scrollView.append(component: expenseComponent, last: idx == result.count - 1)
            }
        })
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.create()
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
}
