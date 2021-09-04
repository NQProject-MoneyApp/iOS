//
//  ViewController.swift
//  MoneyApp
//
//  Created by Szymon Gęsicki on 05/06/2021.
//

import UIKit
import SnapKit

class GroupListViewController: UIViewController, GroupComponentDelegate, ScrollViewRefreshDelegate {
    
    func didPressGroupComponent(group: Group) {
        guard let vc = GroupDetailsViewController.loadFromStoryboard() else { return }
        vc.group = group
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(didEnterFromBackground), name:
                UIApplication.willEnterForegroundNotification, object: nil)
        loadGroups()
        // todo add activity indicator
    }
    
    @objc func didEnterFromBackground() {
        loadGroups()
    }
    
    // ScrollView refresh indicator callback
    func didRefreshList(refreshCompletion: @escaping () -> Void) {
        service.fetchGroups(completion: { result in
            self.updateGroupsList(groups: result)
            
            refreshCompletion()
        })
    }
    
    func loadGroups() {
        service.fetchGroups(completion: { result in
            self.updateGroupsList(groups: result)
        })
    }
    
    @objc private func onLogout() {
        guard let vc = LoginViewController.loadFromStoryboard() else { return }
        let controller = UINavigationController(rootViewController: vc)
        
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
    }
    
    private func updateGroupsList(groups: [Group]) {
        
        if groups.isEmpty {
            // todo add information about no groups
            print("TODO: EMPTY GROUPS")
        }
        
        self.groups = groups
        scrollView.clearComponents()
        
        for (idx, group) in groups.enumerated() {
            let groupView = GroupComponentView()
            groupView.create(group: group, delegate: self)
            scrollView.appendVertical(component: groupView, last: idx == groups.count - 1)
        }
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

    private func setupObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(onLogout), name: NSNotification.Name("logout"), object: nil)
    }
    
    private func setupNavigationController() {
        navigationController?.setBackgroundColor(color: UIColor.brand.blackBackground)
        title = "Groups"
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        let leftBarItem = UIBarButtonItem(image: UIImage(named: "add"), style: .plain, target: self, action: #selector(onProfileButtonTapped))
        leftBarItem.tintColor = UIColor.brand.yellow
        
        navigationItem.leftBarButtonItem = leftBarItem
    
    }
    
    @objc func onProfileButtonTapped() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)

        let logoutAction = UIAlertAction(title: "Logout", style: .destructive) { _ in
            Authentication.shared.logout()
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.overrideUserInterfaceStyle = .dark
        alert.view.tintColor = UIColor.brand.yellow
        
        alert.addAction(logoutAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func createGroupOptionMenu() -> UIMenu {
        
        let join = UIAction(title: "Join",image: UIImage()) { _ in
            self.showJoinAlert()
        }
        let add = UIAction(title: "Add", image: UIImage()) { _ in } //TODO

        return UIMenu( title: "What would you like to do?", children: [join, add])
    }
    
    private func showJoinAlert() {
        let alert = UIAlertController(title: "Enter the code", message: nil, preferredStyle: .alert)
        alert.overrideUserInterfaceStyle = .dark;
        alert.view.tintColor = UIColor.brand.yellow
        
        alert.addTextField { textField in
            textField.placeholder = "Code"
            textField.tintColor = UIColor.brand.yellow
            textField.addTarget(self, action: #selector(self.textChanged), for: .editingChanged)
        }
        
        alert.addAction(UIAlertAction(title: "Back", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Join", style: .default, handler: { _ in
            self.joinToGroup(code: alert.textFields?.first?.text)
        }))
        
        alert.actions[1].isEnabled = false
 
        present(alert, animated: true)
    }
    
    @objc func textChanged(_ sender: Any) {
        if let textField = sender as? UITextField{
            var resp : UIResponder! = textField
            while !(resp is UIAlertController) { resp = resp.next }
            let alert = resp as! UIAlertController
            alert.actions[1].isEnabled = (textField.text != "")}
    }
    
    private func joinToGroup(code: String?) {
        if let code = code, !code.isEmpty {
            GroupListService.shared.joinGroup(code: code) { result in
                Toast.shared.presentToast(result)
            }
        }
    }
    
    private func createUserMenu() -> UIMenu {
        let logout = UIAction(title: "Logout", image: UIImage()) { _ in
            Authentication.shared.logout()
        }

        return UIMenu( title: "What would you like to do?", children: [logout])
    }
}

