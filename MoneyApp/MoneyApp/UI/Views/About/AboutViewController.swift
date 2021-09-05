//
//  AboutViewController.swift
//  MoneyApp
//
//  Created by Szymon Gęsicki on 05/09/2021.
//

import Foundation
import UIKit

class AboutViewController: UIViewController {
    
    private let scrollView = ScrollView()
    private let sourceUrl: String = "https://github.com/NQProject-MoneyApp"
    
    static func loadFromStoryBoard() -> AboutViewController? {
        let storyboard = UIStoryboard(name: "AboutView", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "AboutView") as? AboutViewController
    }
    
    override func viewDidLoad() {
        
        view.backgroundColor = UIColor.brand.blackBackground
        setupNavigationController()
        setupScrollView()
        
        appendHeader(text: "Creators")
        appendConent(text: "Danielle Saldanha", attribute: "danielle.saldanha98@gmail.com")
        appendConent(text: "Szymon Gęsicki", attribute: "szym.gesicki@gmail.com")
        appendConent(text: "Jędrzej Głowaczewski", attribute: "x.speerit@gmail.com")
        appendHeader(text: "Source code")
        appendUrlButton(url: sourceUrl, last: true)

    }
    
    private func setupNavigationController() {
        navigationController?.setBackgroundColor(color: UIColor.brand.blackBackground)
        title = "About"
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.tintColor = UIColor.brand.yellow
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.create()
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
    
    @objc func onButtonPressed() {
        if let url = URL(string: sourceUrl) {
            UIApplication.shared.open(url)
        }
    }
    
    private func appendUrlButton(url: String, last: Bool = false) {
        let button = UIButton()
        button.setTitle(url, for: .normal)
        button.titleLabel?.textColor = UIColor.white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(onButtonPressed), for: .touchUpInside)
        scrollView.appendVertical(component: button, last: last)
    }
    
    private func appendHeader(text: String, last: Bool = false) {
        let label = createLabel(text: text, textColor: UIColor.brand.yellow, fontSize: 20)
        scrollView.appendVertical(component: label, last: last)
    }
    
    private func appendConent(text: String, attribute: String, last: Bool = false) {
        let container = UIView()
        
        let textLabel = createLabel(text: text, textColor: UIColor.white, fontSize: 15)
        let attributeLabel = createLabel(text: attribute, textColor: UIColor.brand.middleGray, fontSize: 15)

        container.addSubview(textLabel)
        container.addSubview(attributeLabel)
        
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(container.snp.top)
            make.centerX.equalTo(container.snp.centerX)
        }
        
        attributeLabel.snp.makeConstraints { make in
            make.top.equalTo(textLabel.snp.bottom).offset(8)
            make.centerX.equalTo(container.snp.centerX)
            make.bottom.equalTo(container.snp.bottom)
        }
        
        scrollView.appendVertical(component: container, last: last)
    }
    
    private func createLabel(text: String, textColor: UIColor, fontSize: CGFloat) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.text = text
        label.textColor = textColor
        label.textAlignment = .center
        return label
    }
}
