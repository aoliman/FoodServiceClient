//
//  VerifyCodeViewController.swift
//  FoodServiceProvider
//
//  Created by Index on 12/13/17.
//  Copyright © 2017 index-pc. All rights reserved.
//

import UIKit
import Material
import RxKeyboard
import RxSwift
class VerifyCodeForgetPasswordVC: UIViewController {
    
    var didSetupConstraints = false
    var phone: String?
    
    var loginRepo = UserRepository()
    private let disposeBag = DisposeBag()
    
    
    let logo: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "food_service_logo")
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var verifyCodeLabel: UILabel = {
        let label = UILabel()
        label.text = "Activation code".localized()
        label.font = UIFont.appFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor =  UIColor.init(hex: "4695a5")
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var phoneLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.appFont(ofSize: 15)
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    
    var wrongButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.appFont(ofSize: 14)
        button.titleLabel?.textAlignment = .center
        button.setTitle("Wrong?".localized(),  for: .normal)
        button.setTitleColor(UIColor.init(hex: "4695a5"), for: .normal)
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //declare view elements
    let verifyCodeTextField: ErrorTextField = {
        let text = ErrorTextField()
        text.placeholder = "Activation code".localized()
        text.setAlignment()
        text.validator.build(.notEmpty).show()
        text.keyboardType = .numbersAndPunctuation
        text.textColor = .darkGray
        text.translatesAutoresizingMaskIntoConstraints  = false
        text.changeActiveColorPlaceholder()
        return text
    }()
    
    lazy var verifyCodeButton: RaisedButton = {
        
        let button = RaisedButton(title: "Confirm activation code".localized(), titleColor: .white)
        button.titleLabel?.font = UIFont.appFontRegular(ofSize: 16)
        button.backgroundColor = UIColor.appColor()
        button.titleLabel?.textAlignment = .left
        button.layer.cornerRadius = 10
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints  = false
        button.pulseColor = .white
        button.setTitle("Confirm activation code".localized(),  for: .normal)
        button.rx.tap.asDriver().drive(onNext: {
            self.hideKeyboardWhenTappedAround()
            self.verifyCodeAction()
        }).disposed(by: self.disposeBag)
        return button
    }()
    //--------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneLabel.text = phone
        self.setupView()
        self.setupNavigationBar()
        addSubviews()
        validationAndKeyboard()
        self.navigationController?.isNavigationBarHidden = true
        hideKeyboardWhenTappedAround()
        
    }
    
    func validationAndKeyboard() {
        loginRepo.isValid(observables:
            self.verifyCodeTextField.validator.isValid
            ).subscribe(onNext: { (boolValue) in
                UiHelpers.setEnabled(button: self.verifyCodeButton, isEnabled: boolValue)
                
            }, onError: { (eroro) in
                
            }, onCompleted: {
                
            }).disposed(by: self.disposeBag)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension VerifyCodeForgetPasswordVC
{
    func verifyCodeAction()
    {
        guard let codeText = self.verifyCodeTextField.text else {
            return
        }
        
        if DataUtlis.data.isInternetAvailable() {
            Loader.showLoader()
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            
            loginRepo.VerifyCodeforgetPassword(phone: phone!, verify_code: codeText, onSuccess: { (statusCode) in
                Loader.hideLoader()
                UIApplication.shared.isNetworkActivityIndicatorVisible = false

                let vc = ResetPasswordVC()
                vc.phone = self.phone
                self.navigationController?.pushViewController(vc, animated: true)
                //got
            }, onFailure: { (error, statuscode) in
                Loader.hideLoader()
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                let errorMessage = error?.error[0].msg
                DataUtlis.data.WarningDialog(Title: "Error".localized(), Body: errorMessage!)

            })
        }
            else {
                DataUtlis.data.noInternetDialog()
            }
            
        }
    }



