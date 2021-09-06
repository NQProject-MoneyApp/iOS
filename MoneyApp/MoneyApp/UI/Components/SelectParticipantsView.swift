//
//  SelectParticipantsView.swift
//  MoneyApp
//
//  Created by aidmed on 05/09/2021.
//

import Foundation
import UIKit

class ParticipantModel {
    let userId: Int
    let username: String
    var isSelected: Bool
    
    init(userId: Int, username: String, isSelected: Bool) {
        self.userId = userId
        self.username = username
        self.isSelected = isSelected
    }
    
    func toggle() {
        isSelected = !isSelected
    }
}

class SelectParticipantsView: UIView {
 
    private var stackView = UIStackView()
    
    private var _participants: [ParticipantModel] = []
    
    var participants: [ParticipantModel] {
        get {
            return _participants
            
        }
        set(newValue) {
            _participants = newValue
            updateList()
        }
    }
 
    func create() {
        backgroundColor = UIColor.brand.darkGray
        layer.cornerRadius = 10.0
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(self.snp.edges).inset(18)
        }
        
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 8
        
    }
    
    private func updateList() {
        
        stackView.arrangedSubviews.forEach({ view in
            view.removeFromSuperview()
        })
        
        let title = UILabel()
        title.text = "Participants"
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 20)
        title.textColor = UIColor.white
        
        stackView.addArrangedSubview(title)
        
        participants.forEach { p in
            let view = ParticipantView()
            view.create(participant: p)
            stackView.addArrangedSubview(view)
        }
        
    }
}

class ParticipantView: UIView {
    
    private var participant: ParticipantModel?
    
    private let nameText = UILabel()
    private let toggleButton = UIButton(type: .system)
    
    func create(participant: ParticipantModel) {
        self.participant = participant
        
        addSubview(nameText)
        addSubview(toggleButton)
        
        nameText.snp.makeConstraints { make in
            make.left.bottom.top.equalTo(self)
            make.right.equalTo(toggleButton.snp.left)
        }
        
        nameText.text = participant.username
        nameText.font = UIFont.systemFont(ofSize: 16)
        nameText.textColor = UIColor.white
        
        toggleButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        setButtonTitle()
        
        toggleButton.snp.makeConstraints { make in
            make.width.equalTo(70)
            make.right.bottom.top.equalTo(self)
            make.left.equalTo(nameText.snp.right)
        }
        
        toggleButton.addTarget(self, action: #selector(didToggle), for: .touchUpInside)
    }
    
    @objc func didToggle() {
        participant!.toggle()
        setButtonTitle()
    }
    
    private func setButtonTitle() {
        if participant!.isSelected {
            toggleButton.setTitle("+", for: .normal)
            toggleButton.setTitleColor(UIColor.brand.yellow, for: .normal)

        } else {
            toggleButton.setTitle("-", for: .normal)
            toggleButton.setTitleColor(UIColor.red, for: .normal)
        }
    }
}
