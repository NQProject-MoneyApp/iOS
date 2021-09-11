//
//  AddExpenseView.swift
//  MoneyApp
//
//  Created by Milosz on 05/09/2021.
//

import Foundation
import UIKit

class AddExpenseViewController: UIViewController {
    
    var groupId: Int?
    var members: [User]?
    
    var editedExpense: Expense?
    
    private let service = ExpenseService()
    
    private let expenseNameTextField = UITextField()
    private let amountTextField = UITextField()
    private let participantsView = SelectParticipantsView()
    private let saveButton = UIButton(type: .system)
    
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
        
        if let expense = editedExpense {
            expenseNameTextField.text = expense.name
            amountTextField.text = "\(expense.amount)"
        }
 
        expenseNameTextField.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(view.snp.top).offset(39)
            make.right.left.equalTo(view).inset(34)
        }
        
        amountTextField.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(expenseNameTextField.snp.bottom).offset(21)
            make.right.left.equalTo(view).inset(34)
        }
    }
    
    private func addParticipants() {
        participantsView.create()
        participantsView.participants = members!.map { member in
            
            let found = editedExpense?.participants.first(where: { id in member.pk == id })
            return ParticipantModel(userId: member.pk, username: member.name, isSelected: found != nil)
        }
        
        view.addSubview(participantsView)
        
        participantsView.snp.makeConstraints { make in
            make.top.equalTo(amountTextField.snp.bottom).offset(21)
            make.right.equalTo(view).inset(34)
            make.left.equalTo(view).inset(34)
        }
    }
    
    private func addSaveButton() {
        view.addSubview(saveButton)
        
        saveButton.defaultStyle(title: "Save")

        saveButton.addTarget(self, action: #selector(didPressSaveButton), for: .touchUpInside)
        
        saveButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(participantsView.snp.bottom).offset(21)
            make.right.left.equalTo(view).inset(34)
        }
    }
    
    @objc func didPressSaveButton() {
        
        let name = expenseNameTextField.text
        let amountStr = amountTextField.text
        
        if name == nil || name!.isEmpty {
            Toast.shared.presentToast("Expense name is empty")
            return
        }
        if amountStr == nil || amountStr!.isEmpty {
            Toast.shared.presentToast("Expense amount is empty")
            return
        }
        
        let amount = Double(amountStr!)
        if amount == nil {
            Toast.shared.presentToast("Expense amount is not a number")
            return
        }
        
        let participants = participantsView.participants
            .filter { $0.isSelected }
            .map { $0.userId }
        
        if participants.isEmpty {
            Toast.shared.presentToast("Add at least one participant")
            return
        }
        
        setLoading(enabled: true)
        
        if let editedExpense = editedExpense {
            let expense = Expense(id: editedExpense.id, name: name!, amount: amount!, participants: participants, author: editedExpense.author)
            
            service.editExpense(groupId: groupId!, expense: expense, completion: { result in
                self.onSaveResult(success: result)
            })
            
        } else {
            let expense = Expense(
                id: 0,
                name: name!,
                amount: amount!,
                participants: participantsView.participants
                    .filter { $0.isSelected }
                    .map { $0.userId },
                author: User(pk: 0, name: "", email: "", balance: 0)
            )
            
            service.addExpense(groupId: groupId!, expense: expense, completion: { result in
                self.onSaveResult(success: result)
            })
        }
        
    }
    
    func onSaveResult(success: Bool) {
        if !success {
            Toast.shared.presentToast("Failed to save expense, plese check your internet connection.")
            setLoading(enabled: false)
        } else {
            self.navigationController!.popViewController(animated: true)
        }
    }
    
    func setLoading(enabled: Bool) {
        saveButton.isEnabled = !enabled
    }
}
