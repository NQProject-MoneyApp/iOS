//
//  CircleProfileComponent.swift
//  MoneyApp
//
//  Created by Szymon Gęsicki on 11/09/2021.
//

import Foundation
import UIKit

class CircleProfileComponent: UIView {
    
    func create(name: String) {
        
        let circle = createCirle()

        addSubview(circle)

        circle.snp.makeConstraints { make in
            make.centerX.equalTo(snp.centerX)
            make.bottom.top.equalTo(self).inset(25)
            make.height.width.equalTo(120)
        }

        let label = createLabel(name: name)

        circle.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalTo(circle.snp.center)
        }
    }
    
    private func createCirle() -> UIView {
        let circle = UIView()
        circle.layer.borderWidth = 2
        circle.layer.borderColor = UIColor.brand.yellow.cgColor
        circle.backgroundColor = UIColor.brand.darkGray
        circle.layer.cornerRadius = 60
        
        return circle
    }
    
    private func createLabel(name: String) -> UILabel {
        let label = UILabel()
        label.text = String(name.prefix(2)).uppercased()
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textColor = UIColor.brand.middleGray
        
        return label
    }
}
