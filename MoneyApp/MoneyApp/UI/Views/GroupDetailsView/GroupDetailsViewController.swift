//
//  GroupDetailsViewController.swift
//  MoneyApp
//
//  Created by Danielle Saldanha on 04/09/2021.
//

import Foundation
import UIKit

class GroupDetailsViewController: UIViewController {
    
    var group: Group?
    private let scrollView = ScrollView()
    
    func didPressNewExpense() {
        // todo
    }
    
    static func loadFromStoryboard() -> GroupDetailsViewController? {
        let storyboard = UIStoryboard(name: "GroupDetailsView", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "GroupDetailsView") as? GroupDetailsViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.brand.blackBackground
        setupScrollView()
        guard let group = group else { return }
        setupNavigationController(name: group.name)
        setupContent(group: group)
       }
    
    private func setupContent(group: Group) {
        let icon = createIconComponent(icon: group.icon.icon())

        let groupValuesView = GroupValuesComponentView()
        groupValuesView.create(group: group)
        
        let settleUpButton = PrimaryButton()
        setupSettleUpButton(button: settleUpButton)

        let newExpenseButton = PrimaryButton()
        setupExpenseButton(button: newExpenseButton)
        let groupUsersList = GroupUsersListComponentView()
        groupUsersList.create(members: group.members)
        
        scrollView.appendVertical(component: icon, last: false)
        scrollView.appendVertical(component: groupValuesView, last: false)
        scrollView.appendVertical(component: settleUpButton, last: false)
        scrollView.appendVertical(component: newExpenseButton, last: false)
        scrollView.appendVertical(component: groupUsersList, last: true)
    }
    
    private func setupNavigationController(name: String) {
        title = name
        navigationController?.navigationBar.tintColor = UIColor.brand.yellow
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
    
    private func createIconComponent(icon: String) -> UIView {
        let container = UIView()
        let iconView = UIImageView()
        iconView.image = UIImage(named: icon)?.aspectFittedToHeight(128)
        iconView.setImageColor(color: UIColor.brand.yellow)
        
        container.addSubview(iconView)
        iconView.snp.makeConstraints { make in
            make.centerX.equalTo(container.snp.centerX)
            make.top.equalTo(container.snp.top)
            make.bottom.equalTo(container.snp.bottom)
        }
        
        return container
    }
    
    private func setupSettleUpButton(button: UIButton) {
        button.setTitle("Settle up", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.setTitleColor(UIColor.brand.yellow, for: .normal)
    }
    
    private func setupExpenseButton(button: UIButton) {
        button.setTitle("New expense", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor.brand.yellow
        button.layer.cornerRadius = 10
    }
}
