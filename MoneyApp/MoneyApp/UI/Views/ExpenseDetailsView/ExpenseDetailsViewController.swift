//
//  ExpenseDetailsViewController.swift
//  MoneyApp
//
//  Created by Danielle Saldanha on 11/09/2021.
//

import Foundation
import UIKit

class ExpenseDetailsViewController: UIViewController {
    
    var expense: Expense?
    private let scrollView = ScrollView()
    
    static func loadFromStoryboard() -> ExpenseDetailsViewController? {
        let storyboard = UIStoryboard(name: "ExpenseDetailsView", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "ExpenseDetailsView") as? ExpenseDetailsViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.brand.blackBackground
        setupScrollView()
        guard let expense = expense else { return }
        setupNavigationController(name: expense.name)
        setupContent(expense: expense)
    }
    
    private func setupContent(expense: Expense) {
        let valuesComponent = ExpenseDetailsComponentView()
        valuesComponent.create(expense: expense)
        
        let dateLabel = UILabel()
        dateLabel.textAlignment = .center
        dateLabel.numberOfLines = 2
        styleLabel(label: dateLabel, text: "Created on \n 11.09.2021")
        
        scrollView.append(component: valuesComponent, last: false)
        scrollView.append(component: dateLabel, last: true)
    }
    
    private func setupNavigationController(name: String) {
        title = name
        navigationController?.navigationBar.tintColor = UIColor.brand.yellow
    }
    
    private func styleLabel(label: UILabel, text: String) {
        label.text = text
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = UIColor.brand.middleGray
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.create()
        
        scrollView.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.top.equalTo(view.snp.top)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
}
