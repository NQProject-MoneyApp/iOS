//
//  ControlViewController.swift
//  MoneyApp
//
//  Created by Szymon Gęsicki on 19/07/2021.
//

import Foundation
import UIKit

class ControlViewController: UIViewController {
    
    static func loadFromStoryBoard() -> ControlViewController? {
        let storyboard = UIStoryboard(name: "ControlView", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "ControlView") as? ControlViewController
    }
    
    
    func nazwaFunkcji(val: Int, val2: Double, val3: String, asd: Int16, asdd: UInt8) {

    }
}
