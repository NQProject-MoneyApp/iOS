//
//  GroupComponentView.swift
//  MoneyApp
//
//  Created by Szymon Gęsicki on 21/08/2021.
//

import Foundation
import UIKit

class GroupComponentView: UIView {
    
    func create(group: Group) {
        setupView()
        
        let star = UIImageView()
        star.image = UIImage(named: group.isFavourite ? "star_selected" : "star")
        
        let icon = UIImageView()
        icon.image = UIImage(named: group.icon)
        
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
            make.width.equalTo(64)
            make.height.equalTo(38)
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
        let balanceLabel = createBalanceLabel(balace: balance)

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
    }
    
    private func createTitleLabel(text: String) -> UILabel {
        let titleLabel = UILabel()
        titleLabel.text = text
        // todo add custom font
        titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
        titleLabel.textColor = UIColor.white
        titleLabel.numberOfLines = 2
        return titleLabel
    }
    
    private func createBalanceLabel(balace: Double) -> UILabel {
        let balanceLabel = UILabel()
        let sign = balace < 0 ? "" : "+"
        balanceLabel.text = "$ \(sign)\(balace.format(".2"))"
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
