//
//  ChangePasswordVC.swift
//  FoodServiceProvider
//
//  Created by Index on 3/7/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import UIKit
import Material

class ChangePasswordVC: UIViewController {
    
   // lazy var profileRepo = ProfileRepo()
    
    let icon: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.fontAwesome(ofSize: 16)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
    }()
    
    let oldPasswordTextField: UITextField = {
        let text = TextField()
        text.tag = 1
        text.placeholder = "oldPassword".localized()
        text.setAlignment()
        text.isSecureTextEntry = true
        text.changeActiveColorPlaceholder()
        text.translatesAutoresizingMaskIntoConstraints  = false
        
        return text
    }()
    
    
    let newPasswordTextField: UITextField = {
        let text = TextField()
        text.tag = 2
        text.placeholder = "newPassword".localized()
        text.setAlignment()
        text.isSecureTextEntry = true
        text.translatesAutoresizingMaskIntoConstraints  = false
        text.changeActiveColorPlaceholder()

        return text
    }()
    
    let confirmPasswordTextField: ErrorTextField = {
        let text = ErrorTextField()
        text.placeholder = "Confirm Password".localized()
        text.setAlignment()
        text.tag = 3
        text.detail = "Password doesn't match".localized()
        text.isSecureTextEntry = true
        text.translatesAutoresizingMaskIntoConstraints  = false
        text.changeActiveColorPlaceholder()

        return text
    }()
    
    let mainView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        addSubviews()
        self.setupNavigationBar()
        self.setupView()
        self.setupDelegate()
        hideKeyboardWhenTappedAround()
        
        view.setNeedsUpdateConstraints()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupDelegate() {
        
        oldPasswordTextField.delegate = self
        newPasswordTextField.delegate = self
        confirmPasswordTextField.delegate = self
    }
}

extension ChangePasswordVC : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField.tag == 3 {
            icon.removeFromSuperview()
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField.tag == 3 {
            if newPasswordTextField.text != textField.text {
                confirmPasswordTextField.isErrorRevealed = true
            }
        }
    }
    
    
}

extension ChangePasswordVC {
    func changePasswordAction() {
//        if (passwordTextField.text?.isEmpty)! {
//            Loader.hideLoader()
//
//            passwordTextField.addValidationIcon(validationErrorLabel: self.validationErrorLabel)
//
//        } else  if (confirmPasswordTextField.text?.isEmpty)! {
//            confirmPasswordTextField.addValidationIcon(validationErrorLabel: self.validationErrorLabel)
//
//        } else if passwordTextField.text != confirmPasswordTextField.text {
//            Loader.hideLoader()
//
//            confirmPasswordTextField.addValidationIcon(validationErrorLabel: self.validationErrorLabel)
//        } else {
//            if let id = self.passedReponseApi?.user.id {
        
                //                profileRepo.changePassword(id: id , password: passwordTextField.text!, completion: { (response, statusCode) in
                //                    switch statusCode {
                //                    case StatusCode.complete.rawValue :
                //                        Loader.hideLoader()
                //                        DataUtlis.data.SuccessDialog(Title: "Success".localized(), Body: "successEdit".localized())
                //                        self.navigationController?.popViewController(animated: true)
                //                    case StatusCode.badRequest.rawValue:
                //                        Loader.hideLoader()
                //                        DataUtlis.data.ErrorDialog(Title: "Error".localized(), Body: "badRequest")
                //
                //                    case StatusCode.unauthorized.rawValue:
                //                        Loader.hideLoader()
                //                        DataUtlis.data.ErrorDialog(Title: "Error".localized(), Body: "unauthenticated")
                //
                //                    case StatusCode.forbidden.rawValue:
                //                        Loader.hideLoader()
                //                        DataUtlis.data.ErrorDialog(Title: "Error".localized(), Body: "forbidden")
                //
                //                    case StatusCode.notFound.rawValue:
                //                        Loader.hideLoader()
                //                        DataUtlis.data.ErrorDialog(Title: "Error".localized(), Body: "not Found")
                //
                //
                //                    case StatusCode.unprocessableEntity.rawValue:
                //                        Loader.hideLoader()
                //                        DataUtlis.data.ErrorDialog(Title: "Error".localized(), Body: "un processable Entity")
                //
                //
                //                    case StatusCode.serverError.rawValue :
                //                        Loader.hideLoader()
                //                        DataUtlis.data.ErrorDialog(Title: "Error".localized(), Body: "ServrError".localized())
                //
                //
                //
                //                    default:
                //                        DataUtlis.data.noInternetDialog()
                //                        Loader.hideLoader()
                //
                //
                //                    }
                //
                //
                //                })
                
//            } else {
//                DataUtlis.data.ErrorDialog(Title:"Error".localized() , Body: "error in parse id ")
//            }
//        }
    }
    
    
    func addSubviews() {
        
        view.addSubview(mainView)
        mainView.addSubview(oldPasswordTextField)
        mainView.addSubview(newPasswordTextField)
        mainView.addSubview(confirmPasswordTextField)
        
        mainView.snp.makeConstraints {
            make in
            make.top.equalTo(self.view.snp.top).offset(20)
            make.height.equalTo(150)
            make.bottom.equalTo(self.view.snp.bottom).offset(-20)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
        }
        
        oldPasswordTextField.snp.makeConstraints {
            
            (make) -> Void in
            make.bottom.equalTo(newPasswordTextField.snp.top).offset(-25)
            make.left.equalTo(self.view.snp.left).offset(20)
            make.right.equalTo(self.view.snp.right).offset(-20)
            make.height.equalTo(30)
        }
        
        newPasswordTextField.snp.makeConstraints {
            
            (make) -> Void in
            make.centerY.equalTo(mainView.snp.centerY)
            make.left.equalTo(self.view.snp.left).offset(20)
            make.right.equalTo(self.view.snp.right).offset(-20)
            make.height.equalTo(30)
        }
        
        confirmPasswordTextField.snp.makeConstraints {
                (make) -> Void in
                make.top.equalTo(newPasswordTextField.snp.bottom).offset(25)
                make.width.equalTo(newPasswordTextField.snp.width)
                make.centerX.equalTo(self.view.snp.centerX)
                make.height.equalTo(30)
        }

    }
}

