//
//  ScrollView.swift
//  MoneyApp
//
//  Created by Szymon Gęsicki on 21/08/2021.
//

import Foundation
import UIKit

class ScrollView: UIView {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private var components: [UIView] = []
    private var edgeInsets: UIEdgeInsets = UIEdgeInsets(top: 32, left: 32, bottom: 32, right: 32)

    
    func create() {
        addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        scrollView.addSubview(contentView)
                
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalTo(scrollView)
            make.left.right.equalTo(self)
        }
    }
    
    func appendVertical(component: UIView, last: Bool) {
            
        contentView.addSubview(component)
        
        component.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(edgeInsets.left)
            
            if let last = components.last {
                make.top.equalTo(last.snp.bottom).offset(edgeInsets.top)
            } else {
                make.top.equalTo(contentView).offset(edgeInsets.top)
            }
            
            if last {
                make.bottom.equalTo(contentView.snp.bottom).offset(-32)
            }
        }
        
        components.append(component)
    }
}
