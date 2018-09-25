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

extension ResetPasswordVC
{
    
    func addSubviews()
    {
        view.addSubview(logoView)
        logoView.addSubview(logo)
        view.addSubview(mainView)
        
        mainView.addSubview(passwordTextField)
        mainView.addSubview(confirmpasswordTextField)
        mainView.addSubview(resetButton)
        
        
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
        
        passwordTextField.snp.makeConstraints
            {
                (make) -> Void in
                make.bottom.equalTo(confirmpasswordTextField.snp.top).offset(-45)
                make.left.equalTo(mainView.snp.left)
                make.right.equalTo(mainView.snp.right)
                make.height.equalTo(30)
        }
        
        confirmpasswordTextField.snp.makeConstraints
            {
                (make) -> Void in
                make.centerY.equalTo(mainView.snp.centerY)
                make.width.equalTo(passwordTextField.snp.width)
                make.centerX.equalTo(mainView.snp.centerX)
                make.height.equalTo(30)
        }
        
     
        
        
        
        resetButton.snp.makeConstraints
            {
                make in
                make.top.equalTo(confirmpasswordTextField.snp.bottom).offset(25)
                make.centerX.equalTo(mainView.snp.centerX)
                make.width.equalTo(mainView.snp.width).multipliedBy(0.7)
                make.height.equalTo(50)
        }
        
        
     
        
    }
    
    func buttonsActions()
    {
        resetButton.addTarget(self, action: #selector(forgetPasswordAction), for: .touchUpInside)

    }
    
   
    @objc func goToSignUp()
    {
        let vc = SignUpVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    func SetupDelegate()
    {
        self.confirmpasswordTextField.delegate = self
        self.passwordTextField.delegate = self
    }
    
    func setupNavBar()
    {
        self.navigationController?.navigationBar.backgroundColor =  UIColor.appColor()
        self.navigationController?.navigationBar.barTintColor =  UIColor.appColor()
    }
    
    func navigationToController()
    {
        
    }
    
    @objc func forgetPasswordAction()
    {
        //        let forgetPasswordPhoneViewController = ForgetPasswordPhoneViewController()
        //        self.navigationController?.pushViewController(forgetPasswordPhoneViewController, animated: true)
    }
    
}

