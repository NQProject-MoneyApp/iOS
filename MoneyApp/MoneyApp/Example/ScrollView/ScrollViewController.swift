//
//  ScrollViewController.swift
//  MoneyApp
//
//  Created by Szymon Gęsicki on 19/07/2021.
//

import Foundation
import UIKit

class Component: UIView {
    
    func setup(member: Member) {
        let name = UILabel()
        let amount = UILabel()
        
        name.text = member.name
        amount.text = "\(member.amount)"
        
        addSubview(name)
        addSubview(amount)
        
        name.snp.makeConstraints { make in
            make.left.equalTo(snp.left).offset(16)
            make.top.equalTo(snp.top).offset(16)
            make.bottom.equalTo(snp.bottom).offset(-16)
        }
        
        amount.snp.makeConstraints { make in
            make.right.equalTo(snp.right).offset(-16)
            make.top.equalTo(snp.top).offset(16)
            make.bottom.equalTo(snp.bottom).offset(-16)
        }
        
        backgroundColor = .gray
        layer.cornerRadius = 8
        
        addShadow(offset: CGSize(width: 0.0, height: 12.0), radius: 12.0, opacity: 0.2)
    }
    
    private func addShadow(offset: CGSize, radius: CGFloat, opacity: Float) {
        
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
    }
}

class ScrollViewController: UIViewController {
    
    let members = [
        Member(name: "Wujek Dolan", amount: 12.34),
        Member(name: "Miłosz Dolan", amount: 432.41),
        Member(name: "Danielle Dolan", amount: 234.23),
        Member(name: "Jędrzej Dolan", amount: 243.42),
        Member(name: "Jędrek Dolan", amount: 12.89),
        Member(name: "Bliźniak Dolan", amount: 42.12),
        Member(name: "Szymon Dolan", amount: 312.53),
        Member(name: "Ada Dolan", amount: 87.12),
        Member(name: "Wujek Dolan", amount: 12.34),
        Member(name: "Miłosz Dolan", amount: 432.41),
        Member(name: "Danielle Dolan", amount: 234.23),
        Member(name: "Jędrzej Dolan", amount: 243.42),
        Member(name: "Jędrek Dolan", amount: 12.89),
        Member(name: "Bliźniak Dolan", amount: 42.12),
        Member(name: "Szymon Dolan", amount: 312.53),
        Member(name: "Ada Dolan", amount: 87.12),
    ]
    
    static func loadFromStoryBoard() -> ScrollViewController? {
        let storyboard = UIStoryboard(name: "ScrollView", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "ScrollView") as? ScrollViewController
    }
    
    override func viewDidLoad() {
        setupView()
        
        for (index, member) in members.enumerated() {
            append(member: member, last: index == members.count - 1)
        }
    }
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private var components: [Component] = []
    
    private func append(member: Member, last: Bool) {
    
        let component = Component()
        
        contentView.addSubview(component)
        
        component.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.top.equalTo(components.last?.snp.bottom ?? contentView).offset(32)
            if last {
                make.bottom.equalTo(contentView.snp.bottom).offset(-32)
            }
        }
        
        component.setup(member: member)
        components.append(component)
    }
    
    private func setupView() {
        edgesForExtendedLayout = []

        
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
        scrollView.addSubview(contentView)
                
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalTo(scrollView)
            // => IMPORTANT: this makes the width of the contentview static (= size of the screen), while the contentview will stretch vertically
            make.left.right.equalTo(view)
        }
    }
}
