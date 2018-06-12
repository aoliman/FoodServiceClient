//
//  File.swift
//  FoodServiceProvider
//
//  Created by Index on 12/31/17.
//  Copyright © 2017 index-pc. All rights reserved.
//

import Foundation

extension ChangePasswordViewController
{
    func addSubviews()
    {
        view.addSubview(passwordTextField)
        view.addSubview(confirmPasswordTextField)
        view.addSubview(changePasswordButton)
    }
    
    
    override func updateViewConstraints()
    {
        if !didSetupConstraints
        {
            passwordTextField.snp.makeConstraints
            {
                (make) -> Void in
                make.top.equalTo(self.view.snp.top).offset(100)
                make.left.equalTo(self.view.snp.left).offset(20)
                make.right.equalTo(self.view.snp.right).offset(-20)
                make.height.equalTo(50)
            }
            confirmPasswordTextField.snp.makeConstraints
            {
                (make) -> Void in
                make.top.equalTo(passwordTextField.snp.bottom).offset(35)
                make.width.equalTo(passwordTextField.snp.width)
                make.centerX.equalTo(self.view.snp.centerX)
                make.height.equalTo(50)
            }
            changePasswordButton.snp.makeConstraints
            {
                (make) -> Void in
                make.top.equalTo(confirmPasswordTextField.snp.bottom).offset(45)
                make.width.equalTo(passwordTextField.snp.width).multipliedBy(0.7)
                make.centerX.equalTo(self.view.snp.centerX)
                make.height.equalTo(50)
            }
            didSetupConstraints = true
        }
        super.updateViewConstraints()
    }
    
}
