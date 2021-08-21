//
//  ViewController.swift
//  MoneyApp
//
//  Created by Szymon Gęsicki on 05/06/2021.
//

import UIKit
import SnapKit

class GroupListViewController: UIViewController {
    
    private let scrollView = ScrollView()
    private var groups: [Group] = []
    private let service = GroupListService()

    static func loadFromStoryboard() -> GroupListViewController? {
        let storyboard = UIStoryboard(name: "GroupListView", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "GroupListView") as? GroupListViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.brand.blackBackground
        setupObserver()
        setupNavigationController()
        setupScrollView()
        
        // todo add activity indicator
        service.fetchGroups(completion: { result in
            if result.isEmpty {
                // todo add information about no groups
                print("EMPTY GROUPS")
            }
            
            self.groups = result
            self.appendGroupsList()
        })
//        groups = Mock.shared.fetchGroups()
    }
    
    @objc private func logout() {
        guard let vc = LoginViewController.loadFromStoryboard() else { return }
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    private func appendGroupsList() {
        
        for (idx, group) in groups.enumerated() {
            let groupView = GroupComponentView()
            groupView.create(group: group)
            scrollView.appendVertical(component: groupView, last: idx == groups.count - 1)
        }
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

    private func setupObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(logout), name: NSNotification.Name("logout"), object: nil)
    }
    
    private func setupNavigationController() {
        navigationController?.setBackgroundColor(color: UIColor.brand.blackBackground)
        title = "Groups"
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        let rightBarItem = UIBarButtonItem(title: nil, image: UIImage(named: "add"), primaryAction: nil, menu: createGroupOptionMenu())
        let leftBarItem = UIBarButtonItem(title: nil, image: UIImage(named: "add"), primaryAction: nil, menu: createUserMenu())
        
        navigationItem.leftBarButtonItem = leftBarItem
        navigationItem.rightBarButtonItem = rightBarItem

    }
    
    private func createGroupOptionMenu() -> UIMenu {
        
        let join = UIAction(title: "Join", image: UIImage()) { _ in }
        let add = UIAction(title: "Add", image: UIImage()) { _ in }

        return UIMenu( title: "What would you like to do?", children: [join, add])
    }
    
    private func createUserMenu() -> UIMenu {
        let logout = UIAction(title: "Logout", image: UIImage()) { _ in
            Authentication.shared.logout()
        }

        return UIMenu( title: "What would you like to do?", children: [logout])
    }
}

