//
//  ChangePasswordViewController.swift
//  FoodServiceProvider
//
//  Created by Index on 12/31/17.
//  Copyright © 2017 index-pc. All rights reserved.
//

import UIKit
import Material

class ChangePasswordViewController: UIViewController
{
    var id: Int?
    var didSetupConstraints = false
    

    let passwordTextField: UITextField = {
        let text = TextField()
        text.placeholder = "Password".localized()
        text.setAlignment()
        text.isSecureTextEntry = true
        text.translatesAutoresizingMaskIntoConstraints  = false
        text.changeActiveColorPlaceholder()
        return text
    }()
    
    let confirmPasswordTextField: UITextField = {
        let text = TextField()
        text.placeholder = "Confirm Password".localized()
        text.setAlignment()
        text.isSecureTextEntry = true
        text.translatesAutoresizingMaskIntoConstraints  = false
        text.changeActiveColorPlaceholder()
        return text
    }()
    
    let changePasswordButton: UIButton = {
        let button = UIButton.appButton()
        button.setTitle("changePassword".localized(),  for: .normal)
        
        return button
    }()
    
    var validationErrorLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.textColor = .red
        label.font = UIFont.fontAwesome(ofSize: 20)
        label.text = String.fontAwesomeIcon(code: "fa-exclamation-circle")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        addSubviews()
        self.setupView()
        self.setupNavigationBar()
        
        hideKeyboardWhenTappedAround()
        self.navigationItem.setHidesBackButton(true, animated:true);

//        view.setNeedsUpdateConstraints()
        
        changePasswordButton.addTarget(self, action: #selector(changePasswordAction), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension ChangePasswordViewController
{
    @objc func changePasswordAction()
    {

        if passwordTextField.text != confirmPasswordTextField.text
        {
            confirmPasswordTextField.addValidationIcon(validationErrorLabel: self.validationErrorLabel)
        }
        else
        {
//            loginRepo.changePassword(id: self.id!, password: passwordTextField.text!)
//            {
//                (response) in
//                Loader.hideLoader()
//                
//                if response.code == 200
//                {
//                    let loginViewController = LoginViewController()
//                    
//                    self.navigationController?.pushViewController(loginViewController, animated: true)
//                }
//                else
//                {
//                    
//                }
//            }
        }
    }
}

