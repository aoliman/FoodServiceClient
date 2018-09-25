//
//  LoginViewController.swift
//
//  Created by index-pc on 12/7/17.
//  Copyright © 2017 index-pc. All rights reserved.
//

import UIKit
import SnapKit
import Localize_Swift
import Material
import FontAwesome_swift
import RxSwift
import Moya
class ResetPasswordVC: UIViewController
{
    
    var didSetupConstraints = false
    
    var phone:String?
    lazy var repo = UserRepository()
    private let disposeBag = DisposeBag()
    
    
    var isLogged = false
  
    
    //main view
    var logoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints  = false
        return view
    }()
    let logo: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "food_service_logo")
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //main view
    var mainView: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints  = false
        
        return view
    }()
    
    // email text field
    //declare view elements
    let passwordTextField: ErrorTextField = {
        
        let text = ErrorTextField()
        text.placeholder = "ResetPasswordField".localized()
        text.validator.build(.notEmpty, .isValidPhone).show()
        text.textAlignment = .natural
        text.isSecureTextEntry = true
        text.textColor = .darkGray
        text.translatesAutoresizingMaskIntoConstraints  = false
        text.changeActiveColorPlaceholder()
        return text
        
    }()
    
    
    let confirmpasswordTextField: ErrorTextField = {
        let text = ErrorTextField()
        text.validator.build(.notEmpty).show()
        text.placeholder = "ResetConfirmPasswordField".localized()
        text.setAlignment()
        text.textColor = .darkGray
        text.isSecureTextEntry = true
        text.translatesAutoresizingMaskIntoConstraints  = false
        text.changeActiveColorPlaceholder()
        return text
    }()
    
    
    
   
    lazy var resetButton: RaisedButton = {
        let button = RaisedButton(title: "ResetButton".localized(), titleColor: .white)
        button.titleLabel?.font = UIFont.appFontRegular(ofSize: 16)
        button.backgroundColor = UIColor.appColor()
        button.titleLabel?.textAlignment = .left
        button.layer.cornerRadius = 10
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints  = false
        button.pulseColor = .white
        button.setTitle("ResetButton".localized(), for: .normal)
        button.rx.tap.asDriver().drive(onNext: {
            self.hideKeyboardWhenTappedAround()
            self.resetPassword()
        }).disposed(by: self.disposeBag)
        return button
    }()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.SetupDelegate()
        
        self.setupNavBar()
        self.setupNavigationBar()

        buttonsActions()
        
        addSubviews()
        
        hideKeyboardWhenTappedAround()
        
        view.setNeedsUpdateConstraints()
        self.navigationItem.setHidesBackButton(true, animated:true)
        repo.isValid(observables: self.confirmpasswordTextField.validator.isValid,
                     self.passwordTextField.validator.isValid
            ).subscribe(onNext: { (boolValue) in
                UiHelpers.setEnabled(button: self.resetButton, isEnabled: boolValue)
            }).disposed(by: self.disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        
        self.setupView()
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.hidesBottomBarWhenPushed  = true
        self.title = "Login".localized()
        self.setupNavBar()
        
        buttonsActions()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
extension ResetPasswordVC :UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == passwordTextField {
            confirmpasswordTextField.becomeFirstResponder()
        }
        
        if textField ==  confirmpasswordTextField  {
            self.dismissKeyboard()
            
          }
        return false
    }
}

//MARK:- this extension for api service
extension ResetPasswordVC
{

    func resetPassword() {
        guard let confirmPasswordText = self.confirmpasswordTextField.text else {
            return
        }
        guard let passwordText = self.passwordTextField.text else {
            return
        }
        
        if passwordText != confirmPasswordText {
            DataUtlis.data.WarningDialog(Title: "Error".localized(), Body: "PasswordAndConfirmPassword".localized())

        } else {
        if DataUtlis.data.isInternetAvailable() {
            Loader.showLoader()
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            repo.resetPassword(newPassword: passwordText, phone: self.phone!, onSuccess: { (statusCode) in
                //got to logi
                if statusCode == 204 ||  statusCode == 200 || statusCode ==  201 {
                    Loader.hideLoader()
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    let vc = LoginVc()
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }, onFailure: { (error, statusCode) in
                Loader.hideLoader()
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                let errorMessage = error?.error[0].msg
                DataUtlis.data.WarningDialog(Title: "Error".localized(), Body: errorMessage!)

            })
            
        } else {
            DataUtlis.data.noInternetDialog()
        }
    }
    }
    
}


