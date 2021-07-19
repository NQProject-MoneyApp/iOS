//
//  TableViewController.swift
//  MoneyApp
//
//  Created by Szymon Gęsicki on 19/07/2021.
//

import Foundation
import UIKit

struct Member {
    let name: String
    let amount: Float
}

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let members = [
        Member(name: "Wujek Dolan", amount: 12.34),
        Member(name: "Miłosz Dolan", amount: 432.41),
        Member(name: "Danielle Dolan", amount: 234.23),
        Member(name: "Jędrzej Dolan", amount: 243.42),
        Member(name: "Jędrek Dolan", amount: 12.89),
        Member(name: "Bliźniak Dolan", amount: 42.12),
        Member(name: "Szymon Dolan", amount: 312.53),
        Member(name: "Ada Dolan", amount: 87.12),
    ]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else { return UITableViewCell() }
        let member = members[indexPath.row]
        cell.setup(name: member.name, amount: member.amount)
        return cell
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    static func loadFromStoryBoard() -> TableViewController? {
        let storyboard = UIStoryboard(name: "TableView", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "TableView") as? TableViewController
    }
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}
