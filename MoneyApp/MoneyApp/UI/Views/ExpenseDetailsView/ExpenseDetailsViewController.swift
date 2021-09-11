//
//  ExpenseDetailsViewController.swift
//  MoneyApp
//
//  Created by Danielle Saldanha on 11/09/2021.
//

import Foundation
import UIKit

class ExpenseDetailsViewController: UIViewController, ScrollViewRefreshDelegate {

    
    var group: Group?
    var expense: Expense?
    private let scrollView = ScrollView()
    
    let service = ExpenseService()
    
    static func loadFromStoryboard() -> ExpenseDetailsViewController? {
        let storyboard = UIStoryboard(name: "ExpenseDetailsView", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "ExpenseDetailsView") as? ExpenseDetailsViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.brand.blackBackground
        setupScrollView()
        guard let expense = expense else { return }
        if group == nil {
            fatalError("Group is nil")
        }
        setupNavigationController(name: expense.name)
        setupContent(expense: expense)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        scrollView.startRefresh()
    }
    
    private func setupContent(expense: Expense) {
        title = expense.name
        scrollView.clearComponents()
        
        let valuesComponent = ExpenseDetailsComponentView()
        valuesComponent.create(expense: expense)
        
        let dateLabel = UILabel()
        dateLabel.textAlignment = .center
        dateLabel.numberOfLines = 2
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"

        styleLabel(label: dateLabel, text: "Created on \n \(dateFormatter.string(from: expense.createDate))")
        
        scrollView.append(component: valuesComponent, last: false)
        scrollView.append(component: dateLabel, last: true)
    }
    
    private func setupNavigationController(name: String) {
        title = name
        navigationController?.navigationBar.tintColor = UIColor.brand.yellow
        
        if #available(iOS 14, *) {
            var rightMenuItems: [UIAction] {
                return [
                    UIAction(title: "Edit", handler: { _ in
                        self.onEditExpenseNavigate()
                    }),
                    UIAction(title: "Delete", handler: { _ in
                        self.onDeleteExpense()
                    })
                ]
            }

            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "hamburger"), menu: UIMenu(children: rightMenuItems))
            navigationItem.rightBarButtonItem?.tintColor = UIColor.brand.yellow
        }
    }
    
    func didRefreshList(refreshCompletion: @escaping () -> Void) {
        service.fetchExpense(groupId: group!.id, expenseId: expense!.id, completion: { result in
            
            if let result = result {
                self.expense = result
            }
            self.setupContent(expense: self.expense!)
            refreshCompletion()
        })
    }
    
    private func onEditExpenseNavigate() {
        guard let vc = AddExpenseViewController.loadFromStoryboard() else { return }
        vc.members = group!.members
        vc.groupId = group!.id
        vc.editedExpense = expense
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func onDeleteExpense() {
        service.deleteExpense(groupId: group!.id, expenseId: expense!.id, completion: { result in
            if result {
                self.navigationController!.popViewController(animated: true)
            } else {
                Toast.shared.presentToast("Failed to delete expense, plese check your internet connection.")
            }
        })
    }
    
    private func styleLabel(label: UILabel, text: String) {
        label.text = text
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = UIColor.brand.middleGray
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.create()
        scrollView.setRefreshDelegate(delegate: self)
        
        scrollView.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.top.equalTo(view.snp.top)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
}
