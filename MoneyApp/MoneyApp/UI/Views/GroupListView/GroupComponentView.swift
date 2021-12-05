//
//  GroupComponentView.swift
//  MoneyApp
//
//  Created by Szymon Gęsicki on 21/08/2021.
//

import Foundation
import UIKit

protocol GroupComponentDelegate: AnyObject {
    func didPressGroupComponent(group: Group)
    func didPressFavouriteIcon(group: Group)
}

class GroupComponentView: ShrinkView {
    
    private weak var delegate: GroupComponentDelegate?
    private var group: Group?
    
    func create(group: Group, delegate: GroupComponentDelegate) {
        self.delegate = delegate
        self.group = group
        setupView()
        
        let star = UIImageView()
        star.image = UIImage(named: group.isFavourite ? "star_selected" : "star")
        star.addTapGesture(tapNumber: 1, target: self, action: #selector(didPressFavouriteIcon))
        
        let icon = UIImageView()
        icon.image = UIImage(named: group.icon.icon())
        icon.setImageColor(color: UIColor.brand.yellow)
        
        let textContainer = createTextContainer(text: group.name, balance: group.userBalance)

        addSubview(star)
        addSubview(icon)
        addSubview(textContainer)

        star.snp.makeConstraints { make in
            make.right.equalTo(snp.right).inset(13)
            make.top.equalTo(snp.top).offset(13)
            make.height.equalTo(19)
            make.width.equalTo(20)
        }
        
        icon.snp.makeConstraints { make in
            make.left.equalTo(snp.left).offset(13)
            make.centerY.equalTo(snp.centerY)
            make.width.greaterThanOrEqualTo(64)
        }
        
        textContainer.snp.makeConstraints { make in
            make.left.equalTo(icon.snp.right).offset(13)
            make.right.equalTo(star.snp.left).offset(-26)
            make.centerY.equalTo(snp.centerY)
        }
        
        appendDateLabel(date: group.createDate)
    }
    
    private func createTextContainer(text: String, balance: Double) -> UIView {
        
        let textContainer = UIView()
        
        let titleLabel = createTitleLabel(text: text)
        let balanceLabel = createBalanceLabel(balance: balance)

        textContainer.addSubview(titleLabel)
        textContainer.addSubview(balanceLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.left.right.top.equalTo(textContainer)
        }
        
        balanceLabel.snp.makeConstraints { make in
            make.left.bottom.equalTo(textContainer)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }

        return textContainer
    }
    
    private func setupView() {
        backgroundColor = UIColor.brand.gray
        layer.cornerRadius = 15
        
        snp.makeConstraints { make in
            make.height.equalTo(137)
        }
        
        addTapGesture(tapNumber: 1, target: self, action: #selector(didPressView))
    }
    
    @objc func didPressView() {
        guard let group = group else { return }
        delegate?.didPressGroupComponent(group: group)
    }
    
    @objc func didPressFavouriteIcon() {
        guard let group = group else { return }
        delegate?.didPressFavouriteIcon(group: group)
    }

    private func createTitleLabel(text: String) -> UILabel {
        let titleLabel = UILabel()
        titleLabel.text = text
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = UIColor.white
        titleLabel.numberOfLines = 2
        return titleLabel
    }
    
    private func createBalanceLabel(balance: Double) -> UILabel {
        let balanceLabel = UILabel()
        balanceLabel.text = "$ \(balance.format(".2"))"
        balanceLabel.textColor = UIColor.white
        return balanceLabel
    }
    
    private func appendDateLabel(date: Date) {

        let dateLabel = UILabel()
        dateLabel.text = dateFormat(date: date)
        dateLabel.textColor = UIColor.brand.middleGray
        
        addSubview(dateLabel)
    
        dateLabel.snp.makeConstraints { make in
            make.right.equalTo(snp.right).inset(13)
            make.bottom.equalTo(snp.bottom).inset(13)
        }
    }
    
    private func dateFormat(date: Date) -> String {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"

        return dateFormatter.string(from: date)
    }
}
