//
//  TextWithButton.swift
//  MoneyApp
//
//  Created by aidmed on 04/09/2021.
//

import Foundation
import UIKit

class TextWithButton: UIView {
    
    private var tapDelegate: (() -> Void)?
    
    func create(labelText: String, buttonText: String, onTap: @escaping () -> Void) {
        self.tapDelegate = onTap
        
        let text = UILabel()
        
        text.text = labelText
        text.textColor = UIColor.white
        text.font = UIFont.systemFont(ofSize: 18)
        
        addSubview(text)
        
        text.snp.makeConstraints { make in
            make.left.equalTo(snp.left)
            make.centerY.equalTo(snp.centerY)
            make.top.equalTo(snp.top)
            make.bottom.equalTo(snp.bottom)
        }
        
        let resetButton = UIButton()
        resetButton.setTitle(buttonText, for: .normal)
        resetButton.setTitleColor(UIColor.brand.yellow, for: .normal)
        
        resetButton.addTarget(self, action: #selector(onTapAction), for: .touchUpInside)
        
        addSubview(resetButton)
    
        resetButton.snp.makeConstraints { make in
            make.left.equalTo(text.snp.right).offset(13)
            make.right.equalTo(snp.right)
            make.centerY.equalTo(snp.centerY)
        }
    }
    
    @objc private func onTapAction() {
        tapDelegate?()
    }
    
}
