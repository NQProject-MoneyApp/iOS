//
//  ScrollView.swift
//  MoneyApp
//
//  Created by Szymon Gęsicki on 21/08/2021.
//

import Foundation
import UIKit

protocol ScrollViewRefreshDelegate {
    func didRefreshList(refreshCompletion: @escaping () -> Void)
}

class ScrollView: UIView {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private var components: [UIView] = []
    private var edgeInsets: UIEdgeInsets = UIEdgeInsets(top: 32, left: 32, bottom: 32, right: 32)
    private var refreshDelegate: ScrollViewRefreshDelegate?
    
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
    
    func setRefreshDelegate(delegate: ScrollViewRefreshDelegate) {
        
        refreshDelegate = delegate
        
        scrollView.refreshControl = UIRefreshControl()
        scrollView.refreshControl?.tintColor = UIColor.brand.yellow
        scrollView.refreshControl?.addTarget(self, action:
                                              #selector(handleRefreshControl),
                                              for: .valueChanged)
   }
    
    func startRefresh() {
        // TODO
        let offsetPoint = CGPoint.init(x: 0, y: scrollView.contentOffset.y - scrollView.refreshControl!.frame.size.height)
        scrollView.setContentOffset(offsetPoint, animated: true)
        scrollView.refreshControl?.beginRefreshing()
        handleRefreshControl()
        
    }
    
    @objc private func handleRefreshControl() {
        refreshDelegate?.didRefreshList(refreshCompletion: {
            DispatchQueue.main.async {
              self.scrollView.refreshControl?.endRefreshing()
           }
        })
    }
    
    func clearComponents() {
        components.forEach { item in
            item.removeFromSuperview()
        }
        components = []
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
    
    func setSingleContent(content: UIView) {
        clearComponents()
        
        contentView.addSubview(content)
        
        content.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(edgeInsets.left)
            make.top.equalTo(contentView).offset(edgeInsets.top).offset(128)
            make.bottom.equalTo(contentView.snp.bottom).offset(-32)
     
        }
    }
}
