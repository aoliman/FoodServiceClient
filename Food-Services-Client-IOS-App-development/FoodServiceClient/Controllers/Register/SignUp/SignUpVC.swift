//
//  RegisterMainViewController.swift
//  FoodServiceProvider
//
//  Created by index-pc on 12/10/17.
//  Copyright © 2017 index-pc. All rights reserved.
//

import UIKit
import Material
import DropDown
import RxKeyboard
import RxSwift
import Moya
class SignUpVC: UIViewController {
    
    lazy var repo = UserRepository()
    private let disposeBag = DisposeBag()

    var didSetupConstraints = false

    let logo: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "food_service_logo")
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.init(hex: "4695a5")
        label.text = "Register".localized()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
   
    var mainView: UIScrollView = {
        let view = UIScrollView()
        
        view.translatesAutoresizingMaskIntoConstraints  = false
        
        return view
    }()
    
    // email text field
    let emailTextField: ErrorTextField = {
        
        let text = ErrorTextField()
        text.changeActiveColorPlaceholder()
        text.validator.build(.notEmpty, .email).show()
        text.placeholder = "Email".localized()
        text.setAlignment()
        text.keyboardType = .emailAddress
        text.translatesAutoresizingMaskIntoConstraints  = false
        
        return text
    }()
    
    // username text field
    lazy var  userNameTextField: ErrorTextField = {
        
        let text = ErrorTextField()
        text.validator.build(.notEmpty).show()
        text.changeActiveColorPlaceholder()
        text.placeholder = "User Name".localized()
        text.setAlignment()
        text.translatesAutoresizingMaskIntoConstraints  = false
        
        return text
    }()
    
  
    
    var phoneTextField: ErrorTextField = {
        
        let text = ErrorTextField()
        text.validator.build(.notEmpty,.isValidPhone).show()
        text.changeActiveColorPlaceholder()
        text.placeholder = "Mobile".localized()
        text.setAlignment()
        text.keyboardType = .numberPad
        text.translatesAutoresizingMaskIntoConstraints  = false
        
        return text
    }()
    
    lazy var  showPasswordButton:UIButton = {
        let button = Button(type: .custom)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.fontAwesome(ofSize: 20)
        button.setTitleColor(UIColor(red:0.27, green:0.58, blue:0.65, alpha:0.5), for: .selected)
        button.setTitle( String.fontAwesomeIcon(code: "fa-eye-slash"), for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.rx.tap.asDriver().drive(onNext: {
            self.showPasswordAction()
        }).disposed(by: self.disposeBag)
        
        return button
    }()
    
    lazy var showConfirmPasswordButton:UIButton = {
        let button = Button(type: .custom)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.fontAwesome(ofSize: 20)
        button.setTitleColor(UIColor(red:0.27, green:0.58, blue:0.65, alpha:0.5), for: .selected)
        button.setTitle( String.fontAwesomeIcon(code: "fa-eye-slash"), for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.rx.tap.asDriver().drive(onNext: {
            self.showConfirmPasswordAction()
        }).disposed(by: self.disposeBag)
        
        return button
    }()
    
    lazy var addressTextField: ErrorTextField = {
        let text = ErrorTextField()
        text.validator.build(.notEmpty).show()
        text.changeActiveColorPlaceholder()
        text.placeholder = "Address".localized()
        text.setAlignment()
        text.translatesAutoresizingMaskIntoConstraints  = false
        
        return text
    }()
    
    let passwordTextField: ErrorTextField = {
        let text = ErrorTextField()
        text.changeActiveColorPlaceholder()
        text.validator.build(.notEmpty).show()
        text.placeholder = "Password".localized()
        text.setAlignment()
        text.isSecureTextEntry = true
        text.translatesAutoresizingMaskIntoConstraints  = false
        
        return text
    }()
    
    let confirmPasswordTextField: ErrorTextField = {
        let text = ErrorTextField()
        text.validator.build(.notEmpty).show()
        text.changeActiveColorPlaceholder()
        text.placeholder = "Confirm Password".localized()
        text.setAlignment()
        text.isSecureTextEntry = true
        text.translatesAutoresizingMaskIntoConstraints  = false
        
        return text
    }()
    
    lazy var continueRegisterButton: RaisedButton = {
        let button = RaisedButton(title: "Register".localized(), titleColor: .white)
        button.titleLabel?.font = UIFont.appFontRegular(ofSize: 16)
        button.backgroundColor = UIColor.appColor()
        button.titleLabel?.textAlignment = .left
        button.layer.cornerRadius = 10
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints  = false
        button.pulseColor = .white
        button.setTitle("Register".localized(), for: .normal)
        button.rx.tap.asDriver().drive(onNext: {
            self.hideKeyboardWhenTappedAround()
            self.signupService()
        }).disposed(by: self.disposeBag)
        return button
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.SetupDelegate()
        self.setupView()
        self.setupNavigationBar()
        
        
        SetupNavBar()
        
        
        self.mainView.bounces = false
        self.mainView.alwaysBounceVertical = false
        mainView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 681.6)
        
        validationAndKeyboard()
        buttonsActions()
        addSubviews()
        hideKeyboardWhenTappedAround()
        view.setNeedsUpdateConstraints()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func validationAndKeyboard() {
        RxKeyboard.instance.visibleHeight.drive(onNext: { (keyboardVisibleHeight) in
            self.mainView.contentInset.bottom = keyboardVisibleHeight
        }).disposed(by: self.disposeBag)
        
        
        

        repo.isValid(observables: self.emailTextField.validator.isValid,
                        self.passwordTextField.validator.isValid , self.addressTextField.validator.isValid ,
                            self.phoneTextField.validator.isValid,
                            self.passwordTextField.validator.isValid,
                            self.confirmPasswordTextField.validator.isValid
            
            ).subscribe(onNext: { (boolValue) in
                UiHelpers.setEnabled(button: self.continueRegisterButton, isEnabled: boolValue)

            }).disposed(by: self.disposeBag)
        

        
    }
    
   
    
    func showPasswordAction()
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
    
    func showConfirmPasswordAction()
    {
        if showConfirmPasswordButton.titleLabel?.text == String.fontAwesomeIcon(code: "fa-eye")
        {
            showConfirmPasswordButton.setTitleColor(.lightGray, for: .normal)
            showConfirmPasswordButton.setTitle(String.fontAwesomeIcon(code: "fa-eye-slash"),  for: .normal)
            confirmPasswordTextField.isSecureTextEntry = true
        }
        else
        {
            
            showConfirmPasswordButton.setTitleColor(UIColor.appColor(), for: .normal)
            showConfirmPasswordButton.setTitle(String.fontAwesomeIcon(code: "fa-eye"),  for: .normal)
            confirmPasswordTextField.isSecureTextEntry = false
        }
    }
    
    
    
}

extension SignUpVC :UITextFieldDelegate
{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == emailTextField {
            userNameTextField.becomeFirstResponder()
        }
        
        if textField == userNameTextField {
            phoneTextField.becomeFirstResponder()
        }
        
        if textField == phoneTextField {
            addressTextField.becomeFirstResponder()
        }
        
        if textField == addressTextField {
            passwordTextField.becomeFirstResponder()
        }
        
        if textField == passwordTextField {
            confirmPasswordTextField.becomeFirstResponder()
        }
        
        if textField ==  confirmPasswordTextField  {
            self.dismissKeyboard()

        }
        return true
    }
    
    
   
            
    
    
}

extension SignUpVC
{
    
     func signupService()
    {
        if (self.passwordTextField.text == self.confirmPasswordTextField.text) {
        
            guard let emailText = self.emailTextField.text else {
                return
            }
            guard let passwordText = self.passwordTextField.text else {
                return
            }
            guard let phoneText = self.phoneTextField.text else {
                return
            }
            guard let addressText = self.addressTextField.text else {
                return
            }
            
            guard let nameText = self.userNameTextField.text else {
                return
            }
            
            if DataUtlis.data.isInternetAvailable() {
                Loader.showLoader()
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                repo.signup(name: nameText, email: emailText, password: passwordText, phone: phoneText, user_address: addressText, user_type: defaultsKey.userType.rawValue, onSuccess: { (response, statusCode) in
                    //stop loading
                    Loader.hideLoader()
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                  
                    //save data
                    Singeleton.userDefaults.set(response?.token, forKey: defaultsKey.token.rawValue)
                    Singeleton.userDefaults.set(response?.user.id, forKey: defaultsKey.userId.rawValue)
                    Singeleton.userDefaults.set(passwordText, forKey: defaultsKey.userPassword.rawValue)
                    Singeleton.userDefaults.synchronize()
                    
                    //got to next
                    let vc = VerifyCodeVC()
                    vc.phone = phoneText
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                }, onFailure: { (errorResponse, statusCode) in
                    Loader.hideLoader()
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    let errorMessage = errorResponse?.error[0].msg
                    DataUtlis.data.WarningDialog(Title: "Error".localized(), Body: errorMessage!)
                })

            } else {
                DataUtlis.data.noInternetDialog()
            }
            
        } else {
            DataUtlis.data.WarningDialog(Title: "Error".localized(), Body: "PasswordAndConfirmPassword".localized())
        }
    }
}



