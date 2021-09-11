//
//  File.swift
//  MoneyApp
//
//  Created by Milosz on 04/09/2021.
//

import Foundation
import UIKit

extension UITextField {
    
    func defaultStyle(placeholder: String) {
        textColor = UIColor.white
        backgroundColor = UIColor.brand.darkGray
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.brand.middleGray])
        autocorrectionType = .no
        autocapitalizationType = .none
        
        layer.cornerRadius = 10.0
        // left text offset
        layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)

        snp.makeConstraints { make in
            make.edges.equalTo(self.snp.edges)
            make.height.equalTo(49)

        }
    }
    
}
