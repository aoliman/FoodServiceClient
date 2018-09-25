//
//  ExtensionCreditCardInformationViewController.swift
//  FoodServiceProvider
//
//  Created by Index on 12/31/17.
//  Copyright © 2017 index-pc. All rights reserved.
//

import Foundation
import Localize_Swift
import Material

extension CreditCardVc
{
    func addSubviews()
    {
        
        
        scrollView.addSubview(logo)
        scrollView.addSubview(label)
        view.addSubview(scrollView)
        scrollView.addSubview(continueRegisterButton)
        scrollView.addSubview(creditCardNumberTextField)
        scrollView.addSubview(passwordTextField)
        scrollView.addSubview(validateDateLabel)
        scrollView.addSubview(mounthTextField)
        scrollView.addSubview(yearTextField)
        scrollView.addSubview(nameOnCard)
        scrollView.addSubview(countryTextField)
        scrollView.addSubview(validationErrorLabel)
        scrollView.addSubview(postalCodeTextField)
       
    }
    
    func dropDownSetup()
    {
        let mounthTap = UITapGestureRecognizer(target: self, action: #selector(dropDown))
        mounthTextField.addGestureRecognizer(mounthTap)
        mounthTextField.tag = 2
        mounthTextField.addTarget(self, action: #selector(dropDown), for: .touchUpInside)
        if Localize.currentLanguage() == "en"
        {
            monthDropdown.anchorView = mounthTextField
        } else {
            monthDropdown.anchorView = yearTextField
        }
        monthDropdown.bottomOffset = CGPoint(x: (monthDropdown.anchorView?.plainView.bounds.minX)!, y:((monthDropdown.anchorView?.plainView.bounds.height)! + 50))
        monthDropdown.dismissMode = .automatic
        monthDropdown.dataSource = months
        monthDropdown.selectionAction =
        {
            [unowned self] (index: Int, item: String) in
            self.mounthTextField.placeholderLabel.isHidden = true
            self.mounthTextField.text = item
        }
        
        let yearTap = UITapGestureRecognizer(target: self, action: #selector(dropDown))
        yearTextField.addGestureRecognizer(yearTap)
        yearTextField.tag = 1
        yearTextField.addTarget(self, action: #selector(dropDown), for: .touchUpInside)
        if Localize.currentLanguage() == "en"
        {
            yearDropdown.anchorView = yearTextField
        }else{
            yearDropdown.anchorView = mounthTextField
        }
        yearDropdown.bottomOffset = CGPoint(x: 0, y:((yearDropdown.anchorView?.plainView.bounds.height)! + 50))
        yearDropdown.dismissMode = .automatic
        yearDropdown.dataSource = years
        yearDropdown.selectionAction =
        {
            [unowned self] (index: Int, item: String) in
            self.yearTextField.placeholderLabel.isHidden = true
            self.yearTextField.text = item
        }

        let countryTap = UITapGestureRecognizer(target: self, action: #selector(dropDown))
        countryTextField.addGestureRecognizer(countryTap)
        countryTextField.tag = 3
        countryTextField.addTarget(self, action: #selector(dropDown), for: .touchUpInside)
        countryDropdown.anchorView = countryTextField
        countryDropdown.bottomOffset = CGPoint(x: 0, y:((countryDropdown.anchorView?.plainView.bounds.height)! + 50))
        countryDropdown.dismissMode = .automatic
        countryDropdown.dataSource = countries
        countryDropdown.selectionAction =
        {
            [unowned self] (index: Int, item: String) in
            self.countryTextField.placeholderLabel.isHidden = true
            self.countryTextField.text = item
        }
    }
    
    
   @objc func dropDown(tapGestureRecognizer: UITapGestureRecognizer)
    {
        if tapGestureRecognizer.view?.tag == 1
        {
            yearDropdown.show()
        }
        else if tapGestureRecognizer.view?.tag == 2
        {
            monthDropdown.show()
        }
        else if tapGestureRecognizer.view?.tag == 3
        {
            countryDropdown.show()
        }
    }
    
    override func updateViewConstraints()
    {
        if (!didSetupConstraints)
        {
            scrollView.snp.makeConstraints
            {
                (make) -> Void in
                make.top.equalTo(self.view.snp.top)
                make.left.equalTo(self.view.snp.left)
                make.right.equalTo(self.view.snp.right)
                make.bottom.equalTo(self.view.snp.bottom)
            }
            logo.snp.makeConstraints
            {
                (make) -> Void in
                make.top.equalTo(scrollView.snp.top).offset(50)
                //                make.width.equalTo(self.view.snp.width).multipliedBy(0.9)
                //                make.centerX.equalTo(self.view.snp.centerX)
                make.left.equalTo(self.view.snp.left).offset(20)
                make.right.equalTo(self.view.snp.right).offset(-20)
                make.height.equalTo(self.view.snp.height).multipliedBy(0.12)
            }
            label.snp.makeConstraints
            {
                (make) -> Void in
                make.height.equalTo(30)
                make.centerX.equalTo(self.view.snp.centerX)
                make.width.equalTo(self.view.snp.width).multipliedBy(0.9)
                make.top.equalTo(logo.snp.bottom).offset(10)
            }
            creditCardNumberTextField.snp.makeConstraints
            {
                (make) -> Void in
                make.height.equalTo(35)
                make.centerX.equalTo(self.view.snp.centerX)
                make.width.equalTo(self.view.snp.width).multipliedBy(0.9)
                make.top.equalTo(label.snp.bottom).offset(25)
            }
            passwordTextField.snp.makeConstraints
            {
                (make) -> Void in
                make.height.equalTo(35)
                make.centerX.equalTo(self.view.snp.centerX)
                make.width.equalTo(self.view.snp.width).multipliedBy(0.9)
                make.top.equalTo(creditCardNumberTextField.snp.bottom).offset(25)
            }
            validateDateLabel.snp.makeConstraints
            {
                make in
                make.height.equalTo(20)
                make.centerX.equalTo(self.view.snp.centerX)
                make.width.equalTo(self.view.snp.width).multipliedBy(0.9)
                make.top.equalTo(passwordTextField.snp.bottom).offset(25)
            }
            if Localize.currentLanguage() == "en"
            {
                mounthTextField.snp.makeConstraints
                    {
                        make in
                        make.height.equalTo(35)
                        make.left.equalTo(passwordTextField.snp.left)
                        make.width.equalTo(passwordTextField.snp.width).multipliedBy(0.48)
                        make.top.equalTo(validateDateLabel.snp.bottom)
                }
                yearTextField.snp.makeConstraints
                    {
                        make in
                        make.height.equalTo(35)
                        make.right.equalTo(passwordTextField.snp.right)
                        make.width.equalTo(passwordTextField.snp.width).multipliedBy(0.48)
                        make.top.equalTo(validateDateLabel.snp.bottom)
                }
            }
            else
            {
                
                mounthTextField.snp.makeConstraints
                    {
                        make in
                        make.height.equalTo(35)
                        make.right.equalTo(passwordTextField.snp.right)
                        make.width.equalTo(passwordTextField.snp.width).multipliedBy(0.48)
                        make.top.equalTo(validateDateLabel.snp.bottom)
                }
                yearTextField.snp.makeConstraints
                    {
                        make in
                        make.height.equalTo(35)
                        make.left.equalTo(passwordTextField.snp.left)
                        make.width.equalTo(passwordTextField.snp.width).multipliedBy(0.48)
                        make.top.equalTo(validateDateLabel.snp.bottom)
                }
                
            }
            nameOnCard.snp.makeConstraints
            {
                make in
                make.height.equalTo(35)
                make.centerX.equalTo(self.view.snp.centerX)
                make.width.equalTo(self.view.snp.width).multipliedBy(0.9)
                make.top.equalTo(mounthTextField.snp.bottom).offset(25)
            }
            countryTextField.snp.makeConstraints
            {
                make in
                make.height.equalTo(35)
                make.centerX.equalTo(self.view.snp.centerX)
                make.width.equalTo(self.view.snp.width).multipliedBy(0.9)
                make.top.equalTo(nameOnCard.snp.bottom).offset(25)
            }
            postalCodeTextField.snp.makeConstraints
            {
                make in
                make.height.equalTo(35)
                make.centerX.equalTo(self.view.snp.centerX)
                make.width.equalTo(self.view.snp.width).multipliedBy(0.9)
                make.top.equalTo(countryTextField.snp.bottom).offset(25)
            }
            continueRegisterButton.snp.makeConstraints
            {
                make in
                make.top.equalTo(postalCodeTextField.snp.bottom).offset(45)
                make.centerX.equalTo(scrollView.snp.centerX)
             //   make.width.equalTo(scrollView.snp.width).multipliedBy(0.7)
             //   make.height.equalTo(50)
            }
            didSetupConstraints = true
        }
        super.updateViewConstraints()

    }
    @objc func keyboardWillShow(_ notification: NSNotification)
    {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = keyboardSize.height
        }
    }
    
   @objc func keyboardWillHide(_ notification: NSNotification) {
        scrollView.contentInset.bottom = 0
    }
    
    func SetupDelegate()
    {
        self.creditCardNumberTextField.delegate = self
        self.passwordTextField.delegate = self
        self.nameOnCard.delegate = self
        self.mounthTextField.delegate = self
        self.yearTextField.delegate = self
        self.countryTextField.delegate = self
        self.postalCodeTextField.delegate = self
    }
    
}

