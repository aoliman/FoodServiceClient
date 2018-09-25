//
//  ExtensionVerifyCode.swift
//  FoodServiceProvider
//
//  Created by Index on 12/13/17.
//  Copyright © 2017 index-pc. All rights reserved.
//

import UIKit
import SnapKit
import Localize_Swift
import PopupDialog

extension VerifyCodeVC
{
    func addSubviews()
    {
        view.addSubview(logo)
        view.addSubview(verifyCodeLabel)
        view.addSubview(verifyCodeTextField)
        view.addSubview(wrongButton)
        view.addSubview(phoneLabel)
        view.addSubview(verifyCodeButton)
        
        logo.snp.makeConstraints
            {
                (make) -> Void in
                make.top.equalTo(self.view.snp.top).offset(100)
                make.left.equalTo(self.view.snp.left)
                make.right.equalTo(self.view.snp.right)
                make.height.equalTo(self.view.snp.height).multipliedBy(0.12)
        }
        verifyCodeLabel.snp.makeConstraints
            {
                (make) -> Void in
                make.top.equalTo(logo.snp.bottom).offset(40)
                make.left.equalTo(self.view.snp.left).offset(25)
                make.right.equalTo(self.view.snp.right).offset(-25)
                make.height.equalTo(30)
        }
        phoneLabel.snp.makeConstraints
            {
                (make) -> Void in
                make.top.equalTo(verifyCodeLabel.snp.bottom)
                make.left.equalTo(self.view.snp.left).offset(25)
                make.right.equalTo(self.view.snp.right).offset(-25)
                make.height.equalTo(30)
        }
        wrongButton.snp.makeConstraints
            {
                (make) -> Void in
                make.top.equalTo(phoneLabel.snp.bottom)
                make.centerX.equalTo(self.view.snp.centerX)
                make.width.equalTo(self.view.snp.width).multipliedBy(0.5)
                make.height.equalTo(40)
        }
        verifyCodeTextField.snp.makeConstraints
            {
                (make) -> Void in
                make.top.equalTo(wrongButton.snp.bottom).offset(15)
                make.left.equalTo(self.view.snp.left).offset(25)
                make.right.equalTo(self.view.snp.right).offset(-25)
                make.height.equalTo(30)
        }
        verifyCodeButton.snp.makeConstraints
            {
                (make) -> Void in
                make.top.equalTo(verifyCodeTextField.snp.bottom).offset(35)
                make.centerX.equalTo(self.view.snp.centerX)
                make.width.equalTo(self.view.snp.width).multipliedBy(0.7)
                make.height.equalTo(50)
        }
        
   }
    

   
    
    
}

