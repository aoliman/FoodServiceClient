//
//  EtensionLoginViewController.swift
//  FoodServiceProvider
//
//  Created by index-pc on 12/9/17.
//  Copyright © 2017 index-pc. All rights reserved.
//

import UIKit
import SnapKit
import Localize_Swift

extension LoginVc
{
    
    func addSubviews()
    {
        view.addSubview(logoView)
        logoView.addSubview(logo)
        view.addSubview(mainView)
        
        mainView.addSubview(validationErrorLabel)
        mainView.addSubview(emailTextField)
        mainView.addSubview(passwordTextField)
        mainView.addSubview(showPasswordButton)
        mainView.addSubview(loginButton)
        view.addSubview(forgetPasswordButton)
        view.addSubview(registerView)
        registerView.addSubview(noAccountLabel)
        registerView.addSubview(registerButton)
    }
    
    func buttonsActions()
    {
        forgetPasswordButton.addTarget(self, action: #selector(forgetPasswordAction), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(Login), for: .touchUpInside)
        showPasswordButton.addTarget(self, action: #selector(showPasswordAction), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(goToSignUp), for: .touchUpInside)
    }
    
    //update view constraints
    override func updateViewConstraints()
    {
        if (!didSetupConstraints)
        {
            logoView.snp.makeConstraints
                {
                    (make) in
                    make.bottom.equalTo(mainView.snp.top)
                    make.left.equalTo(self.view.snp.left).offset(25)
                    make.right.equalTo(self.view.snp.right).offset(-25)
                    make.top.equalTo(self.view.snp.top).offset(70)
            }
            logo.snp.makeConstraints
                {
                    (make) in
                    make.height.equalTo(140)
                    make.left.equalTo(self.view.snp.left).offset(25)
                    make.right.equalTo(self.view.snp.right).offset(-25)
                    make.centerY.equalTo(logoView.snp.centerY)
            }
            mainView.snp.makeConstraints
                {
                    (make) -> Void in
                    make.height.equalTo(250)
                    make.centerY.equalTo(self.view.snp.centerY)
                    make.left.equalTo(self.view.snp.left).offset(25)
                    make.right.equalTo(self.view.snp.right).offset(-25)
            }
            emailTextField.snp.makeConstraints
                {
                    (make) -> Void in
                    make.bottom.equalTo(passwordTextField.snp.top).offset(-45)
                    make.left.equalTo(mainView.snp.left)
                    make.right.equalTo(mainView.snp.right)
                    make.height.equalTo(30)
            }
            passwordTextField.snp.makeConstraints
                {
                    (make) -> Void in
                    make.centerY.equalTo(mainView.snp.centerY)
                    make.width.equalTo(emailTextField.snp.width)
                    make.centerX.equalTo(mainView.snp.centerX)
                    make.height.equalTo(30)
            }
            
            if(Localize.currentLanguage() == "en")
            {
                showPasswordButton.snp.makeConstraints
                    {
                        make in
                        make.right.equalTo(passwordTextField.snp.right).offset(-10)
                        make.width.equalTo(30)
                        make.height.equalTo(passwordTextField.snp.height)
                        make.centerY.equalTo(passwordTextField.snp.centerY)
                }
                noAccountLabel.snp.makeConstraints
                    {
                        make in
                        make.top.equalTo(registerView.snp.top)
                        make.width.equalTo(140)
                        make.height.equalTo(30)
                        make.left.equalTo(registerView.snp.left)
                        
                }
                registerButton.snp.makeConstraints
                    {
                        make in
                        make.top.equalTo(registerView.snp.top).multipliedBy(0.9)
                        make.left.equalTo(noAccountLabel.snp.right)
                        make.height.equalTo(30)
                        make.width.equalTo(60)
                }
              
            }
            else
            {
               
                showPasswordButton.snp.makeConstraints
                    {
                        make in
                        make.left.equalTo(passwordTextField.snp.left).offset(10)
                        make.width.equalTo(30)
                        make.height.equalTo(passwordTextField.snp.height)
                        make.centerY.equalTo(passwordTextField.snp.centerY)
                }
                noAccountLabel.snp.makeConstraints
                    {
                        make in
                        make.top.equalTo(registerView.snp.top)
                        make.width.equalTo(130)
                        make.height.equalTo(passwordTextField)
                        make.right.equalTo(registerView.snp.right)
                }
                registerButton.snp.makeConstraints
                    {
                        make in
                        make.top.equalTo(registerView.snp.top)
                        make.right.equalTo(noAccountLabel.snp.left)
                        make.height.equalTo(passwordTextField)
                        make.width.equalTo(60)
                }
            }
            
            loginButton.snp.makeConstraints
                {
                    make in
                    make.top.equalTo(passwordTextField.snp.bottom).offset(25)
                    make.centerX.equalTo(mainView.snp.centerX)
                    make.width.equalTo(mainView.snp.width).multipliedBy(0.7)
                    make.height.equalTo(50)
            }
            forgetPasswordButton.snp.makeConstraints
                {
                    make in
                    make.top.equalTo(loginButton.snp.bottom).offset(20)
                    make.right.equalTo(loginButton.snp.right)
                    make.height.equalTo(40)
                    make.width.equalTo(loginButton.snp.width)
            }
            registerView.snp.makeConstraints
                {
                    make in
                    make.top.equalTo(forgetPasswordButton.snp.bottom).offset(10)
                    if Localize.currentLanguage() == "en"
                    {
                        make.width.equalTo(200)
                    }
                    else
                    {
                        make.width.equalTo(190)

                    }
                    make.height.equalTo(passwordTextField.snp.height)
                    make.centerX.equalTo(loginButton.snp.centerX)
            }
            
            didSetupConstraints = true
        }
        super.updateViewConstraints()
    }
    
    @objc func goToSignUp()
    {
        let vc = SignUpVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func showPasswordAction()
    {
        if showPasswordButton.titleLabel?.text == String.fontAwesomeIcon(code: "fa-eye")
        {
            showPasswordButton.setTitleColor(.lightGray, for: .normal)
            showPasswordButton.setTitle(String.fontAwesomeIcon(code: "fa-eye-slash"),  for: .normal)
            passwordTextField.isSecureTextEntry = true
        }
        else
        {
            
            showPasswordButton.setTitleColor(UIColor.appColor(), for: .normal)
            showPasswordButton.setTitle(String.fontAwesomeIcon(code: "fa-eye"),  for: .normal)
            passwordTextField.isSecureTextEntry = false
        }
    }
    
    func SetupDelegate()
    {
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
    }
    
    func setupNavBar()
    {
        self.navigationController?.navigationBar.backgroundColor =  UIColor.appColor()
        self.navigationController?.navigationBar.barTintColor    =  UIColor.appColor()
    }
    
    func navigationToController()
    {
       
    }
    
    @objc func forgetPasswordAction()
    {
        let forgetPasswordVC = ForgetPasswordVC()
        self.navigationController?.pushViewController(forgetPasswordVC, animated: true)
    }
  
}

