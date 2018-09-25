//
//  ChangePasswordViewController.swift
//  FoodServiceProvider
//
//  Created by Index on 12/13/17.
//  Copyright © 2017 index-pc. All rights reserved.
//

import UIKit
import Material
import SnapKit
import PopupDialog
import Material
import RxSwift

class ForgetPasswordVC: UIViewController
{
    var didSetupConstraints = false
    
    lazy var repo = UserRepository()
    private let disposeBag = DisposeBag()

    let logo: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "food_service_logo")
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //declare view elements
    let phoneTextField: ErrorTextField = {
       
        let text = ErrorTextField()
        text.placeholder = "Phone number".localized()
        text.validator.build(.notEmpty, .isValidPhone).show()
        text.textAlignment = .natural
        text.keyboardType = .numberPad
        text.textColor = .darkGray
        text.translatesAutoresizingMaskIntoConstraints  = false
        text.changeActiveColorPlaceholder()
        return text
        
    }()
    
   lazy var sendButton: RaisedButton = {
        let button = RaisedButton(title: "Send".localized(), titleColor: .white)
        button.titleLabel?.font = UIFont.appFontRegular(ofSize: 16)
        button.backgroundColor = UIColor.appColor()
        button.titleLabel?.textAlignment = .left
        button.layer.cornerRadius = 10
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints  = false
        button.pulseColor = .white
        button.setTitle("Send".localized(), for: .normal)
        
        button.rx.tap.asDriver().drive(onNext: {
            self.sendCodeAction()
        }).disposed(by: self.disposeBag)
        
        return button
    }()
    //--------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        self.setupNavigationBar()
        
        buttonsActions()
        
        addSubviews()
        
        hideKeyboardWhenTappedAround()
        
        view.setNeedsUpdateConstraints()
        
        repo.isValid(observables:
                     self.phoneTextField.validator.isValid
            ).subscribe(onNext: { (boolValue) in
                UiHelpers.setEnabled(button: self.sendButton, isEnabled: boolValue)
            }).disposed(by: self.disposeBag)
        
        // Do any additional setup after loading the view.
    }

    
    
  
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension ForgetPasswordVC
{
    func sendCodeAction()
    {
        guard let phoneText = self.phoneTextField.text else {
            return
        }
        
        if DataUtlis.data.isInternetAvailable() {
            Loader.showLoader()
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            repo.forgetPassword(phone: phoneText, onSuccess: { (statusCode) in
                //got to verify
                Loader.hideLoader()
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                 let vc = VerifyCodeForgetPasswordVC()
                 vc.phone = phoneText
                 self.navigationController?.pushViewController(vc, animated: true)
            }, onFailure: { (error, statusCode) in
                Loader.hideLoader()
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                //let errorMessage = error?.error[0].msg
                DataUtlis.data.WarningDialog(Title: "Error".localized(), Body: error!)
            })
            
        } else {
            DataUtlis.data.noInternetDialog()

        }
       
    }
}
