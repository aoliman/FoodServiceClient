//
//  ExtensionContactUsVC.swift
//  FoodServiceProvider
//
//  Created by Index on 2/24/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import UIKit
import Foundation
extension ContactUsVC {
    
    func addSubView() {
        view.addSubview(label)
        view.addSubview(emailTextField)
        view.addSubview(nameTextField)
        view.addSubview(messageTextField)
        view.addSubview(sendButton)
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        label.snp.makeConstraints {
            
            make in
            make.centerX.equalTo(self.view.snp.centerX)
//            if #available(iOS 11.0, *) {
//                make.top.equalTo(additionalSafeAreaInsets.top).offset(20)
//            } else {
                make.top.equalTo(self.view.snp.top).offset(30)
//            }
            make.width.equalTo(emailTextField.snp.width)
        }
        emailTextField.snp.makeConstraints {
            (make) -> Void in
            make.top.equalTo(label.snp.bottom).offset(35)
            make.left.equalTo(self.view.snp.left).offset(17)
            make.right.equalTo(self.view.snp.right).offset(-17)
            make.height.equalTo(30)
        }
        nameTextField.snp.makeConstraints {
            (make) -> Void in
            make.top.equalTo(emailTextField.snp.bottom).offset(35)
            make.width.equalTo(emailTextField.snp.width)
            make.centerX.equalTo(self.view.snp.centerX)
            make.height.equalTo(30)
        }
        messageTextField.snp.makeConstraints {
            (make) -> Void in
            make.top.equalTo(nameTextField.snp.bottom).offset(35)
            make.width.equalTo(emailTextField.snp.width)
            make.centerX.equalTo(self.view.snp.centerX)
            make.height.equalTo(30)
        }
        sendButton.snp.makeConstraints {
            make in
            make.centerX.equalTo(self.view.snp.centerX)
            make.width.equalTo(self.view.snp.width).multipliedBy(0.8)
            if UIDevice.current.model == "iPad" {
                make.height.equalTo(70)
                make.top.equalTo(messageTextField.snp.bottom).offset(45)
            } else {
                make.height.equalTo(50)
                make.top.equalTo(messageTextField.snp.bottom).offset(30)
            }
            
        }
    }

}
