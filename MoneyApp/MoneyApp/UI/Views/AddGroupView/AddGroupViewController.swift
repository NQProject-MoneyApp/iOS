//
//  AddGroupViewController.swift
//  MoneyApp
//
//  Created by Szymon Gęsicki on 04/09/2021.
//

import UIKit

class AddGroupViewController: UIViewController {
    
    private let scrollView = ScrollView()
    private let service = GroupListService()
    
    static func loadFromStoryboard() -> AddGroupViewController? {
        let storyboard = UIStoryboard(name: "AddGroupView", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "AddGroupView") as? AddGroupViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.brand.blackBackground
        setupNavigationController()
        setupScrollView()
    }
    
    private func setupNavigationController() {
        navigationController?.setBackgroundColor(color: UIColor.brand.blackBackground)
        title = "Add Group"
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
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
