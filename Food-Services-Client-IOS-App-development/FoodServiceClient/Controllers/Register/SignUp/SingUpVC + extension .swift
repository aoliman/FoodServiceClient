//
//  ExtensionRegisterMainViewController.swift
//  FoodServiceProvider
//
//  Created by index-pc on 12/10/17.
//  Copyright © 2017 index-pc. All rights reserved.
//

import UIKit
import Localize_Swift
import DropDown

extension SignUpVC {
    func addSubviews() {
        view.addSubview(mainView)
        mainView.addSubview(logo)
        mainView.addSubview(titleLabel)
        mainView.addSubview(emailTextField)
        mainView.addSubview(userNameTextField)
        mainView.addSubview(phoneTextField)
        mainView.addSubview(addressTextField)
        mainView.addSubview(passwordTextField)
        mainView.addSubview(confirmPasswordTextField)
        mainView.addSubview(continueRegisterButton)
    }
    
    override func updateViewConstraints() {
        if (!didSetupConstraints) {
            mainView.snp.makeConstraints {
                (make) -> Void in
                make.top.equalTo(self.view.snp.top)
                make.left.equalTo(self.view.snp.left)
                make.right.equalTo(self.view.snp.right)
                make.bottom.equalTo(self.view.snp.bottom)
            }
            logo.snp.makeConstraints {
                (make) -> Void in
                make.top.equalTo(mainView.snp.top).offset(50)
                make.left.equalTo(self.view.snp.left).offset(20)
                make.right.equalTo(self.view.snp.right).offset(-20)
                make.height.equalTo(self.view.snp.height).multipliedBy(0.12)
            }
            titleLabel.snp.makeConstraints {
                (make) -> Void in
                make.height.equalTo(30)
                make.left.equalTo(self.view.snp.left).offset(20)
                make.right.equalTo(self.view.snp.right).offset(-20)
                make.top.equalTo(logo.snp.bottom).offset(20)
            }
            emailTextField.snp.makeConstraints {
                (make) -> Void in
                make.top.equalTo(titleLabel.snp.bottom).offset(35)
                make.left.equalTo(self.view.snp.left).offset(20)
                make.right.equalTo(self.view.snp.right).offset(-20)
                make.height.equalTo(30)
            }
            
            userNameTextField.snp.makeConstraints {
                (make) -> Void in
                make.top.equalTo(emailTextField.snp.bottom).offset(35)
                make.width.equalTo(emailTextField.snp.width)
                make.centerX.equalTo(mainView.snp.centerX)
                make.height.equalTo(30)
            }
            phoneTextField.snp.makeConstraints {
                (make) -> Void in
                make.top.equalTo(userNameTextField.snp.bottom).offset(35)
                make.width.equalTo(emailTextField.snp.width)
                make.centerX.equalTo(mainView.snp.centerX)
                make.height.equalTo(30)
            }
            addressTextField.snp.makeConstraints {
                (make) -> Void in
                make.top.equalTo(phoneTextField.snp.bottom).offset(35)
                make.width.equalTo(emailTextField.snp.width)
                make.centerX.equalTo(mainView.snp.centerX)
                make.height.equalTo(30)
            }
            passwordTextField.snp.makeConstraints {
                (make) -> Void in
                make.top.equalTo(addressTextField.snp.bottom).offset(35)
                make.width.equalTo(emailTextField.snp.width)
                make.centerX.equalTo(mainView.snp.centerX)
                make.height.equalTo(30)
            }
           
            
            confirmPasswordTextField.snp.makeConstraints {
                (make) -> Void in
                make.top.equalTo(passwordTextField.snp.bottom).offset(35)
                make.width.equalTo(emailTextField.snp.width)
                make.centerX.equalTo(mainView.snp.centerX)
                make.height.equalTo(30)
            }
            
           
            continueRegisterButton.snp.makeConstraints {
                make in
                make.top.equalTo(confirmPasswordTextField.snp.bottom).offset(45)
                make.centerX.equalTo(mainView.snp.centerX)
                make.width.equalTo(mainView.snp.width).multipliedBy(0.7)
                make.height.equalTo(50)
            }
            didSetupConstraints = true
        }
        super.updateViewConstraints()
    }
    
    func keyboardWillShow(_ notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            mainView.contentInset.bottom = keyboardSize.height
        }
    }
    
    func keyboardWillHide(_ notification: NSNotification) {
        mainView.contentInset.bottom = 0
    }
    
    func SetupDelegate() {
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.userNameTextField.delegate = self
        self.confirmPasswordTextField.delegate = self
    }
    
    func SetupNavBar() {
            var title = ""
            
            if Localize.currentLanguage() == "en" {
                title = " as " + ("Normal user".localized())
            }
            else {
                title = " ك" + ("Normal user".localized())

            }
        
            self.navigationController?.navigationBar.tintColor = .white
            self.titleLabel.SetAttribute(AppendingattStringTitle: title)
    }
    
    func buttonsActions() {
        
    }
    
   
    
    
   
}


