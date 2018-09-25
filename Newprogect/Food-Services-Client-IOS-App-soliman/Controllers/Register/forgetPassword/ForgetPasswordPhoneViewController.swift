//
//  ChangePasswordViewController.swift
//  FoodServiceProvider
//
//  Created by Index on 12/13/17.
//  Copyright © 2017 index-pc. All rights reserved.
//

import UIKit
import Material

class ForgetPasswordPhoneViewController: UIViewController
{
    var didSetupConstraints = false
    
    var loginRepo = LoginRepo()
    
    let logo: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "food_service_logo")
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //declare view elements
    let phoneTextField: UITextField = {
        let text = TextField()
        text.changeActiveColorPlaceholder()
        text.placeholder = "Phone number".localized()
        text.setAlignment()
        text.textColor = .darkGray
        text.translatesAutoresizingMaskIntoConstraints  = false
        
        return text
    }()
    
    let sendButton: UIButton = {
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
            self.uploadProfileImage()
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
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension ForgetPasswordPhoneViewController
{
    func sendCodeAction()
    {
        if (!(phoneTextField.text?.isEmpty)!)
        {
//            loginRepo.forgetPasswordPhone(phone: phoneTextField.text!)
//            {
//                (response) in
//                
//                Loader.hideLoader()
//                if response.code == 200
//                {
//                    let verifyCodeViewController = VerifyCodeViewController()
//                    verifyCodeViewController.phone = self.phoneTextField.text
//                    verifyCodeViewController.previousViewName = "forgetPasswordPhoneViewController"
//                    self.navigationController?.pushViewController(verifyCodeViewController, animated: true)
//                }
//                else if response.code == 404
//                {
//                    let alert = Alert.showAlert(message: "User not found".localized())
//                    self.present(alert, animated: true, completion: nil)
//                }
//                else
//                {
//                    DataUtlis.data.WarningDialog(Title: "FailedTitle".localized(), Body: "NoInternet".localized())
//                }
//            }
        }
        else
        {
            Loader.hideLoader()
           
        }
    }
}
