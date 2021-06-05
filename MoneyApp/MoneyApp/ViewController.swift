//
//  ViewController.swift
//  MoneyApp
//
//  Created by Szymon Gęsicki on 05/06/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitle()
        setupBackground()
    }
    
    func setupTitle() {
        textLabel.text = "Hello world"
        textLabel.textColor = UIColor.white
        navigationItem.title = Config.APP_NAME
    }
    
    func setupBackground() {
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
        navigationController?.navigationBar.barTintColor = UIColor.gray
    }
}

