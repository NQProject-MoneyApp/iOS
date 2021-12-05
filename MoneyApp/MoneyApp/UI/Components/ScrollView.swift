//
//  ScrollView.swift
//  MoneyApp
//
//  Created by Szymon Gęsicki on 21/08/2021.
//

import Foundation
import UIKit

protocol ScrollViewRefreshDelegate: AnyObject {
    func didRefreshList(refreshCompletion: @escaping () -> Void)
}

enum ScrollViewAxis {
    case horizontal
    case vertical
}

class ScrollView: UIView {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private var components: [UIView] = []
    private var edgeInsets: UIEdgeInsets = UIEdgeInsets(top: 16, left: 24, bottom: 16, right: 24)
    private var axis: ScrollViewAxis = .vertical
    private weak var refreshDelegate: ScrollViewRefreshDelegate?

    func create(axis: ScrollViewAxis = .vertical) {
        self.axis = axis
        
        addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        scrollView.addSubview(contentView)
                
        contentView.snp.makeConstraints { make in
            
            if axis == .horizontal {
                make.top.bottom.equalTo(self)
                make.left.right.equalTo(scrollView)
            } else {
                make.top.bottom.equalTo(scrollView)
                make.left.right.equalTo(self)
            }
        }
    }
    
    func clearComponents() {
        components.forEach { item in
            item.removeFromSuperview()
        }
        components = []
    }
    
    func append(component: UIView, last: Bool) {
            
        contentView.addSubview(component)
        
        if axis == .vertical {
            appendVertical(component: component, last: last)
        } else {
            appendHorizontal(component: component, last: last)
        }
        
        components.append(component)
    }
    
    func setRefreshDelegate(delegate: ScrollViewRefreshDelegate) {
        
        refreshDelegate = delegate
        
        scrollView.refreshControl = UIRefreshControl()
        scrollView.refreshControl?.tintColor = UIColor.brand.yellow
        scrollView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
   }
    
    func startRefresh() {
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
    
    private func appendVertical(component: UIView, last: Bool) {
        
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
    }
    
    private func appendHorizontal(component: UIView, last: Bool) {
        
        component.snp.makeConstraints { make in
            
            if let last = components.last {
                make.left.equalTo(last.snp.right).offset(edgeInsets.left)
            } else {
                make.left.equalTo(contentView).offset(edgeInsets.left)
            }

            make.top.bottom.equalTo(contentView).inset(edgeInsets.top)
                        
            if last {
                make.right.equalTo(contentView.snp.right).offset(-32)
            }
        }
    }
    
    func hideScrollIdicator() {
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
    }

    func setSingleContent(content: UIView) {
        clearComponents()
        
        contentView.addSubview(content)
        
        content.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(edgeInsets.left)
            make.top.equalTo(contentView).offset(edgeInsets.top).offset(128)
            make.bottom.equalTo(contentView.snp.bottom).offset(-32)
     
        }
        
        components.append(content)
    }
}
