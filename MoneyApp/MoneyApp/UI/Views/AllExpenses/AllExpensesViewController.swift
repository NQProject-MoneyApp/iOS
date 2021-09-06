//
//  AllExpensesViewController.swift
//  MoneyApp
//
//  Created by Szymon Gęsicki on 06/09/2021.
//

import Foundation
import UIKit

class AllExpensesViewController: UIViewController {
    
    static func loadFromStoryboard() -> AllExpensesViewController? {
        let storyboard = UIStoryboard(name: "AllExpensesView", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "AllExpensesView") as? AllExpensesViewController
    }

    override func viewDidLoad() {
        view.backgroundColor = UIColor.brand.blackBackground
        title = "All expenses"
    }
}
