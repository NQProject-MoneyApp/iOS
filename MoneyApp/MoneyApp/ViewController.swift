//
//  ViewController.swift
//  MoneyApp
//
//  Created by Szymon Gęsicki on 05/06/2021.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitle()
        setupExample()
        setupBackground()
    }
    
    func setupExample() {
        let controlButton = UIButton()
        let tableButton = UIButton()
        let scrollButton = UIButton()
        
        controlButton.setTitle("control", for: .normal)
        tableButton.setTitle("table", for: .normal)
        scrollButton.setTitle("scroll", for: .normal)
        
        controlButton.addTarget(self, action: #selector(presentControlView), for: .touchUpInside)
        tableButton.addTarget(self, action: #selector(presentTableView), for: .touchUpInside)
        scrollButton.addTarget(self, action: #selector(presentScrollView), for: .touchUpInside)
        
        view.addSubview(controlButton)
        view.addSubview(tableButton)
        view.addSubview(scrollButton)
        
        controlButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(view.snp.top).offset(32)
        }
        
        tableButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(controlButton.snp.bottom).offset(32)
        }
        
        scrollButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(tableButton.snp.bottom).offset(32)
        }
    }
    
    @objc
    func presentControlView() {
        guard let vc = ControlViewController.loadFromStoryBoard() else { return }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    func presentTableView() {
        guard let vc = TableViewController.loadFromStoryBoard() else { return }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    func presentScrollView() {
        guard let vc = ScrollViewController.loadFromStoryBoard() else { return }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupTitle() {
        edgesForExtendedLayout = []
        navigationItem.title = Config.APP_NAME        
    }
    
    func setupBackground() {
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
        navigationController?.navigationBar.barTintColor = UIColor.gray
    }
}

