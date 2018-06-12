//
//  ChangePasswordExtension.swift
//  FoodServiceProvider
//
//  Created by Index on 12/13/17.
//  Copyright © 2017 index-pc. All rights reserved.
//

import UIKit
import SnapKit
import Localize_Swift

extension ForgetPasswordVC
{
    func addSubviews()
    {
        view.addSubview(logo)
        view.addSubview(phoneTextField)
        view.addSubview(sendButton)
        logo.snp.makeConstraints
            {
                (make) -> Void in
                make.top.equalTo(self.view.snp.top).offset(100)
                make.left.equalTo(self.view.snp.left)
                make.right.equalTo(self.view.snp.right)
                make.height.equalTo(self.view.snp.height).multipliedBy(0.12)
        }
        phoneTextField.snp.makeConstraints
            {
                (make) -> Void in
                make.top.equalTo(logo.snp.bottom).offset(40)
                make.left.equalTo(self.view.snp.left).offset(25)
                make.right.equalTo(self.view.snp.right).offset(-25)
                make.height.equalTo(50)
        }
        sendButton.snp.makeConstraints
            {
                make in
                make.top.equalTo(phoneTextField.snp.bottom).offset(30)
                make.centerX.equalTo(self.view.snp.centerX)
                make.width.equalTo(self.view.snp.width).multipliedBy(0.7)
                make.height.equalTo(phoneTextField)
        }
        
    }
    func buttonsActions()
    {
        //sendButton.addTarget(self, action: #selector(sendCodeAction), for: .touchUpInside)
    }
    
    }
