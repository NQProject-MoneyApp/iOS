//
//  ViewController.swift
//  MoneyApp
//
//  Created by Szymon Gęsicki on 05/06/2021.
//

import SnapKit

class GroupListViewController: UIViewController, GroupComponentDelegate, ScrollViewRefreshDelegate {
    
    private let scrollView = ScrollView()
    private var groups: [Group] = []
    private let service = GroupListService()

    // -- GroupComponentDelegate --
    func didPressGroupComponent(group: Group) {
        guard let vc = GroupDetailsViewController.loadFromStoryboard() else { return }
        vc.group = group
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didPressFavouriteIcon(group: Group) {
        group.isFavourite = !group.isFavourite
        service.markAsFavourite(group: group, completion: { result in
            if !result {
                Toast.shared.presentToast("Error on mark favourite")
            } else {
                self.scrollView.startRefresh()
            }
        })
    }

    // ScrollView refresh indicator callback
    func didRefreshList(refreshCompletion: @escaping () -> Void) {
        service.fetchGroups(completion: { result in
            self.updateGroupsList(groups: result)
            
            refreshCompletion()
        })
    }
    
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
        scrollView.startRefresh()
    }
    
    func loadGroups() {
        service.fetchGroups(completion: { result in
            self.updateGroupsList(groups: result)
        })
    }
    
    @objc private func didEnterFromBackground() {
        loadGroups()
    }
    
    @objc private func onLogout() {
        guard let vc = LoginViewController.loadFromStoryboard() else { return }
        let controller = UINavigationController(rootViewController: vc)
        
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
    }
    
    private func updateGroupsList(groups: [Group]) {
        
        self.groups = groups
        scrollView.clearComponents()
        
        if groups.isEmpty {
            let text = UILabel()
            text.text = "No groups yet"
            text.textColor = UIColor.brand.yellow
            text.font = UIFont.systemFont(ofSize: 32)
            text.textAlignment = .center
            scrollView.setSingleContent(content: text)
            
        } else {
            for (idx, group) in groups.enumerated() {
                let groupView = GroupComponentView()
                groupView.create(group: group, delegate: self)
                scrollView.append(component: groupView, last: idx == groups.count - 1)
            }
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(didEnterFromBackground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    private func setupNavigationController() {

        navigationController?.setBackgroundColor(color: UIColor.brand.blackBackground)
        title = "Groups"
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        if #available(iOS 14, *) {
            createContextMenu()

        } else {
            let leftBarItem = UIBarButtonItem(image: UIImage(named: "userProfile"), style: .plain, target: self, action: #selector(onProfileButtonTapped))
            leftBarItem.tintColor = UIColor.white
            
            let rightBarItem = UIBarButtonItem(image: UIImage(named: "add"), style: .plain, target: self, action: #selector(onAddButtonTapped))
            rightBarItem.tintColor = UIColor.brand.yellow
            
            navigationItem.leftBarButtonItem = leftBarItem
            navigationItem.rightBarButtonItem = rightBarItem
        }
    }
    
    @objc func onProfileButtonTapped() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        let profileAction = UIAlertAction(title: "Profile", style: .default) { _ in
            guard let vc = ProfileViewController.loadFromStoryBoard() else { return }
            self.navigationController?.pushViewController(vc, animated: true)
        }

        let logoutAction = UIAlertAction(title: "Logout", style: .destructive) { _ in
            Authentication.shared.logout()
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.view.tintColor = UIColor.brand.yellow
        
        alert.addAction(profileAction)
        alert.addAction(logoutAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func onAddButtonTapped() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)

        let joinAction = UIAlertAction(title: "Join a group", style: .default) { _ in
            self.showJoinAlert()
        }
        
        let addAction = UIAlertAction(title: "Create a new group", style: .default) { _ in
            guard let vc = AddGroupViewController.loadFromStoryboard() else { return }
            self.navigationController?.pushViewController(vc, animated: true)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.view.tintColor = UIColor.brand.yellow

        alert.addAction(joinAction)
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
        
    private func showJoinAlert() {
        let alert = UIAlertController(title: "Enter the code", message: nil, preferredStyle: .alert)
        alert.view.tintColor = UIColor.brand.yellow
        
        alert.addTextField { textField in
            textField.placeholder = "Code"
            textField.tintColor = UIColor.brand.yellow
            textField.addTarget(self, action: #selector(self.textChanged), for: .editingChanged)
        }
        
        alert.addAction(UIAlertAction(title: "Back", style: .default, handler: nil))
        
        let joinAction = UIAlertAction(title: "Join", style: .default, handler: { _ in
            self.joinToGroup(code: alert.textFields?.first?.text)
        })
        
        joinAction.isEnabled = false
        
        alert.addAction(joinAction)
         
        present(alert, animated: true)
    }
    
    @objc func textChanged(_ sender: Any) {
        // todo refactor
        if let textField = sender as? UITextField {
            
            var resp: UIResponder! = textField
            while !(resp is UIAlertController) { resp = resp.next }
            (resp as? UIAlertController)?.actions[1].isEnabled = (textField.text != "")
        }
    }
    
    private func joinToGroup(code: String?) {
        if let code = code, !code.isEmpty {
            GroupListService.shared.joinGroup(code: code) { result in
                Toast.shared.presentToast(result)
                self.scrollView.startRefresh()
            }
        }
    }
    
    private func createContextMenu() {
            if #available(iOS 14, *) {
                var leftMenuItems: [UIAction] {
                    return [
                        UIAction(title: "Profile", handler: { _ in
                            guard let vc = ProfileViewController.loadFromStoryBoard() else { return }
                            self.navigationController?.pushViewController(vc, animated: true)
                        }),
                        UIAction(title: "About", handler: { _ in
                            guard let vc = AboutViewController.loadFromStoryBoard() else { return }
                            self.navigationController?.pushViewController(vc, animated: true)
                        }),
                        UIAction(title: "Logout", handler: { _ in
                            Authentication.shared.logout()
                        })
                    ]
                }
                
                var rightMenuItems: [UIAction] {
                    return [
                        UIAction(title: "Join", handler: { _ in
                            self.showJoinAlert()
                        }),
                        UIAction(title: "Create a new group", handler: { _ in
                            guard let vc = AddGroupViewController.loadFromStoryboard() else { return }
                            self.navigationController?.pushViewController(vc, animated: true)
                        })
                    ]
                }

                navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "add"), menu: UIMenu(children: rightMenuItems))
                navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "userProfile"), menu: UIMenu(children: leftMenuItems))
                
                navigationItem.rightBarButtonItem?.tintColor = UIColor.brand.yellow
                navigationItem.leftBarButtonItem?.tintColor = UIColor.brand.yellow
            }
        }
}
