//
//  AddExpenseView.swift
//  MoneyApp
//
//  Created by aidmed on 05/09/2021.
//

import Foundation
import UIKit

class AddExpenseViewController: UIViewController {
    
    var groupId: Int?
    var members: [User]?
    
    private let service = AddExpenseService()
    
    private let expenseNameTextField = UITextField()
    private let amountTextField = UITextField()
    private let participantsView = SelectParticipantsView()
    private let loginButton = UIButton(type: .system)
    
    static func loadFromStoryboard() -> AddExpenseViewController? {
        let storyboard = UIStoryboard(name: "AddExpenseView", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "AddExpenseView") as? AddExpenseViewController
    }

    override func viewDidLoad() {
        view.backgroundColor = UIColor.brand.blackBackground
        title = "New expense"
        addTextFields()
        addParticipants()
        addSaveButton()
    }
    
    func addTextFields() {
        view.addSubview(expenseNameTextField)
        view.addSubview(amountTextField)
        
        expenseNameTextField.defaultStyle(placeholder: "Expense name")
        amountTextField.defaultStyle(placeholder: "Amount")
 
        expenseNameTextField.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(view.snp.top).offset(39)
            make.right.left.equalTo(view).inset(34)
            make.height.equalTo(49)
        }
        
        amountTextField.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(expenseNameTextField.snp.bottom).offset(21)
            make.right.left.equalTo(view).inset(34)
            make.height.equalTo(49)
        }
    }
    
    private func addParticipants() {
        participantsView.create()
        participantsView.participants = members!.map { member in
            return ParticipantModel(userId: member.pk, username: member.name, isSelected: false)
        }
        
        view.addSubview(participantsView)
        
        participantsView.snp.makeConstraints { make in
            make.top.equalTo(amountTextField.snp.bottom).offset(21)
            make.right.equalTo(view).inset(34)
            make.left.equalTo(view).inset(34)
        }
    }
    
    private func addSaveButton() {
        view.addSubview(loginButton)
        
        loginButton.defaultStyle(title: "Save")

        loginButton.addTarget(self, action: #selector(didPressSaveButton), for: .touchUpInside)
        
        loginButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(participantsView.snp.bottom).offset(21)
            make.right.left.equalTo(view).inset(34)
            make.height.equalTo(49)
        }
    }
    
    @objc func didPressSaveButton() {
        
        let expense = Expense(
            name: expenseNameTextField.text!,
            amount: Double(amountTextField.text!)!,
            participants: participantsView.participants
                .filter { $0.isSelected }
                .map { $0.userId }
        )
        
        service.addExpense(groupId: groupId!, expense: expense, completion: { result in
            Toast.shared.presentToast("Expense added \(result)")
        })
    }
}
