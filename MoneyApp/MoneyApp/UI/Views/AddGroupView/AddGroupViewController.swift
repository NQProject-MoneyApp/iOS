//
//  AddGroupViewController.swift
//  MoneyApp
//
//  Created by Szymon Gęsicki on 04/09/2021.
//

import UIKit

class AddGroupViewController: UIViewController {
    
    private let scrollView = ScrollView()
    private let service = GroupListService()
    private var imagePickerAlert: UIAlertController?
    private var icon: MoneyAppIcon?
    private var iconView = UIImageView()
    
    static func loadFromStoryboard() -> AddGroupViewController? {
        let storyboard = UIStoryboard(name: "AddGroupView", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "AddGroupView") as? AddGroupViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.brand.blackBackground
        setupNavigationController()
        setupScrollView()
        appendIcon()
        
        // remove
        scrollView.append(component: UIView(), last: true)
    }
    
    private func appendIcon() {
        let container = UIView()
        
        let imageContainer = UIView()
        imageContainer.backgroundColor = UIColor.brand.gray
        imageContainer.addTapGesture(tapNumber: 1, target: self, action: #selector(didPressChooseImage))
        imageContainer.layer.cornerRadius = 20

        container.addSubview(imageContainer)
        
        imageContainer.snp.makeConstraints { make in
            make.centerX.equalTo(container.snp.centerX)
            make.width.height.equalTo(132)
            make.top.bottom.equalTo(container)
        }
        
        if let icon = icon {
            iconView.image = UIImage(named: icon.icon())
            iconView.imageColor = UIColor.brand.yellow
        }

        imageContainer.addSubview(iconView)
        iconView.snp.makeConstraints { make in
            make.center.equalTo(imageContainer.snp.center)
        }
        
        scrollView.append(component: container, last: false)
    }
    
    @objc private func didPressChooseImage() {
        presentImagePickerAlert()
    }
    
    private func setupNavigationController() {
        navigationController?.navigationBar.tintColor = UIColor.brand.yellow
        navigationController?.setBackgroundColor(color: UIColor.brand.blackBackground)
        title = "Add Group"
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.create()
        
        scrollView.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.top.equalTo(view.snp.top)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
    
    private func presentImagePickerAlert() {
        imagePickerAlert = UIAlertController(title: "Choose icon", message: nil, preferredStyle: .alert)
        
        guard let imagePickerAlert = imagePickerAlert else { return }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        imagePickerAlert.view.tintColor = UIColor.brand.yellow
        
        imagePickerAlert.addAction(cancelAction)
        
        let scroll = ScrollView()
        scroll.hideScrollIdicator()
        imagePickerAlert.view.addSubview(scroll)
        scroll.create(axis: .horizontal)
        
        scroll.snp.makeConstraints { make in
            make.left.equalTo(imagePickerAlert.view.snp.left)
            make.right.equalTo(imagePickerAlert.view.snp.right)
            make.top.equalTo(imagePickerAlert.view.snp.top).offset(25)
            make.bottom.equalTo(imagePickerAlert.view.snp.bottom).offset(-25)
        }

        for icon in MoneyAppIcon.allCases {
            let image = UIImageView()
            image.image = UIImage(named: icon.icon())
            image.imageColor = UIColor.brand.yellow
            image.tag = icon.rawValue
            image.isUserInteractionEnabled = true
            image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didChooseImage)))

            if let last = MoneyAppIcon.allCases.last {
                scroll.append(component: image, last: icon.rawValue == last.rawValue)
            }
        }
        
        present(imagePickerAlert, animated: true, completion: nil)
    }
    
    @objc private func didChooseImage(gesture: UITapGestureRecognizer) {
        guard let tag = gesture.view?.tag else { return }
        icon = MoneyAppIcon.init(rawValue: tag)
        if let icon = icon {
            iconView.image = UIImage(named: icon.icon())
            iconView.imageColor = UIColor.brand.yellow
        }
        imagePickerAlert?.dismiss(animated: true, completion: nil)
    }
}
