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
    
    override func viewWillAppear(_ animated: Bool) {
        scrollView.startRefresh()
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
        createContextMenu()
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.backgroundColor = UIColor.brand.blackBackground
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
    }
    
    private func showJoinAlert() {
        let joinAlert = JoinAlertController.create(onJoin: { code in
            self.joinToGroup(code: code)
        })
        present(joinAlert, animated: true)
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
            navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        }
    }
}
