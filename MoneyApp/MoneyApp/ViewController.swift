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
        setupBackground()
    }
    
    func setupTitle() {
        let label = UILabel()
        label.text = "Hello world"
        label.textColor = UIColor.white
        
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
        }
        
        navigationItem.title = Config.APP_NAME        
    }
    
    func setupBackground() {
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
        navigationController?.navigationBar.barTintColor = UIColor.gray
    }
}

