//
//  TableViewCell.swift
//  MoneyApp
//
//  Created by Szymon Gęsicki on 19/07/2021.
//

import Foundation
import UIKit


class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var amount: UILabel!
    
    func setup(name: String, amount: Float) {
        self.name.text = name
        self.amount.text = "\(amount)"
    }
}
