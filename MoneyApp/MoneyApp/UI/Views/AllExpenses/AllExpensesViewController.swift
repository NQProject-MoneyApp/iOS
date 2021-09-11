//
//  AllExpensesViewController.swift
//  MoneyApp
//
//  Created by Szymon Gęsicki on 06/09/2021.
//

import Foundation
import UIKit

class AllExpensesViewController: UIViewController, ExpenseComponentDelegate, ScrollViewRefreshDelegate {
    
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
    
    func didRefreshList(refreshCompletion: @escaping () -> Void) {
        guard let group = group else { return }
        
        let now = Date().timeIntervalSince1970
        
        service.fetchExpenses(groupID: group.id, completion: { expenses in
            // quick UI fix
            DispatchQueue.main.asyncAfter(deadline: .now() + (1 - (Date().timeIntervalSince1970 - now))) {
                self.scrollView.clearComponents()
                self.createContent(expenses: expenses)
                refreshCompletion()
            }
        })
    }

    override func viewDidLoad() {
        view.backgroundColor = UIColor.brand.blackBackground
        title = "Expenses"
        
        setupNavigationController()
        
        setupScrollView()
        
        guard let group = group else { return }

        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = UIColor.brand.yellow
        activityIndicator.startAnimating()
        scrollView.setSingleContent(content: activityIndicator)
        
        service.fetchExpenses(groupID: group.id, completion: { expenses in
            self.scrollView.clearComponents()
            self.createContent(expenses: expenses)
            self.scrollView.alpha = 0
            self.scrollView.fadeIn(0.5)
        })
    }
    
    private func setupNavigationController() {
        view.backgroundColor = UIColor.brand.blackBackground
        title = "Expenses"
        
        if #available(iOS 14, *) {
            var rightMenuItems: [UIAction] {
                return [
                    UIAction(title: "Add expense", handler: { _ in
                        self.onNewExpenseNavigate()
                    })
                ]
            }
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "add"), menu: UIMenu(children: rightMenuItems))
            navigationItem.rightBarButtonItem?.tintColor = UIColor.brand.yellow
        }
    }
    
    private func onNewExpenseNavigate() {
        guard let group = group else { return }
        guard let vc = AddExpenseViewController.loadFromStoryboard() else { return }
        vc.members = group.members
        vc.groupId = group.id
        navigationController?.pushViewController(vc, animated: true)
    }
        
    private func createContent(expenses: [Expense]) {
        
        if expenses.isEmpty {
            
            let text = UILabel()
            text.text = "No expenses yet"
            text.textColor = UIColor.brand.yellow
            text.font = UIFont.systemFont(ofSize: 32)
            text.textAlignment = .center
            scrollView.setSingleContent(content: text)
            
        } else {
            for (idx, expense) in expenses.enumerated() {
                let expenseComponent = ExpenseComponent()
                expenseComponent.create(expense: expense, delegate: self)
                scrollView.append(component: expenseComponent, last: idx == expenses.count - 1)
            }
        }
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.create()
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
        scrollView.setRefreshDelegate(delegate: self)
    }
}
