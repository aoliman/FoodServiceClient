//
//  CreditCardVC.swift
//  FoodServiceProvider
//
//  Created by Index on 6/11/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import UIKit
import CreditCardForm
import Stripe
protocol  PresentpopUpcredite {
    func presentPupupCredite()
}

class CreditCardVC: UIViewController, STPPaymentCardTextFieldDelegate {
    var ispopup = false
    var creditCardView = CreditCardFormView() 
    let paymentTextField = STPPaymentCardTextField()
    var registerRepo = GetallProdacteRepo()
    var delegte:PresentpopUpcredite!
    var continueRegisterButton: UIButton = {
        let button = UIButton.appButton()
        button.setTitle("Add Card".localized(),  for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupView()
        setupNavigationBar()
        self.navigationController?.navigationBar.tintColor = .white
        setupNavigationBar()
//        self.navigationItem.backBarButtonItem?.title = "Back".localized()
        self.title = "Add Payment".localize()
        self.view.addSubview(creditCardView)
        self.view.addSubview(continueRegisterButton)
        
        creditCardView.snp.makeConstraints() {
            make in
            make.width.equalTo(300)
            make.height.equalTo(200)
            make.centerX.equalTo(self.view.snp.centerX)
            make.top.equalTo(self.view.snp.top).offset(80)
        }
        
        creditCardView.cardHolderString = "Oraz Atakishiyev"
        createTextField()
        
        continueRegisterButton.snp.makeConstraints {
            make in
            make.centerX.equalTo(self.view.snp.centerX)
            make.width.equalTo(self.view.snp.width).multipliedBy(0.7)
            if UIDevice.current.model == "iPad" {
                make.height.equalTo(70)
                make.top.equalTo(paymentTextField.snp.bottom).offset(55)
            } else {
                make.height.equalTo(50)
                make.top.equalTo(paymentTextField.snp.bottom).offset(35)
                
            }
        }
        continueRegisterButton.addTarget(self, action: #selector(getToken), for: .touchUpInside)
        self.navigationController?.navigationBar.tintColor = .white
    }
    override func viewDidDisappear(_ animated: Bool) {
        if ispopup == true {
            self.delegte.presentPupupCredite()
        }
    }
    func createTextField() {
        
        paymentTextField.frame = CGRect(x: 15, y: 199, width: self.view.frame.size.width - 30, height: 44)
        paymentTextField.delegate = self
        paymentTextField.translatesAutoresizingMaskIntoConstraints = false
        paymentTextField.borderWidth = 0
        
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: paymentTextField.frame.size.height - width, width:  paymentTextField.frame.size.width, height: paymentTextField.frame.size.height)
        border.borderWidth = width
        paymentTextField.layer.addSublayer(border)
        paymentTextField.layer.masksToBounds = true
        
        view.addSubview(paymentTextField)
        
        NSLayoutConstraint.activate([
            paymentTextField.topAnchor.constraint(equalTo: creditCardView.bottomAnchor, constant: 20),
            paymentTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            paymentTextField.widthAnchor.constraint(equalToConstant: self.view.frame.size.width-20),
            paymentTextField.heightAnchor.constraint(equalToConstant: 44)
            ])
    }
    
    func paymentCardTextFieldDidChange(_ textField: STPPaymentCardTextField) {
        creditCardView.paymentCardTextFieldDidChange(cardNumber: textField.cardNumber, expirationYear: textField.expirationYear, expirationMonth: textField.expirationMonth, cvc: textField.cvc)
    }
    
    func paymentCardTextFieldDidEndEditingExpiration(_ textField: STPPaymentCardTextField) {
        creditCardView.paymentCardTextFieldDidEndEditingExpiration(expirationYear: textField.expirationYear)
    }
    
    func paymentCardTextFieldDidBeginEditingCVC(_ textField: STPPaymentCardTextField) {
        creditCardView.paymentCardTextFieldDidBeginEditingCVC()
    }
    
    func paymentCardTextFieldDidEndEditingCVC(_ textField: STPPaymentCardTextField) {
        creditCardView.paymentCardTextFieldDidEndEditingCVC()
    }
    
    @objc func getToken() {
        
        let cardParams = STPCardParams()
        cardParams.number = paymentTextField.cardNumber
        cardParams.expMonth = paymentTextField.expirationMonth
        cardParams.expYear = paymentTextField.expirationYear
        cardParams.cvc = paymentTextField.cvc
       
       
        
        
        
         myLoader.showCustomLoaderview(uiview: self.view)
        
        
        
        STPAPIClient.shared().createToken(withCard: cardParams) { (token, error) in
           
            guard let token = token, error == nil else {
                
                DataUtlis.data.WarningDialog(Title: "FailedTitle".localized(), Body: "please, try again".localized())
                 myLoader.hideCustomLoader()
                return
            }
            print(token)

//            self.registerRepo.submitCreditCard(token: String(describing: token), completion: { (response) in
//            print(response)
//            })
            
            self.registerRepo.AddPayment(Paymenttoken: String(describing: token), completion: { (response) in
                print(response)
                myLoader.hideCustomLoader()
                self.navigationController?.popViewController(animated: true)
                if self.ispopup == true {
                  self.delegte.presentPupupCredite()
                }
                
                
               // self.dismiss(animated: true, completion: nil)
                UIApplication.shared.keyWindow?.rootViewController?.view.makeToast("Credit is Added".localize())
                 myLoader.hideCustomLoader()
            }, Sendempety: { (send) in
                
                if send == true {
                   
                    self.registerRepo.submitCreditCard(token: String(describing: token),  completion: { (responsecard) in
                        print(responsecard)
                        
                         self.dismiss(animated: true, completion: nil)
                        UIApplication.shared.keyWindow?.rootViewController?.view.makeToast("Credit is Added".localize())
                         myLoader.hideCustomLoader()
                    })
                    
                }
            })
            
            
            
//            self.registerRepo.AddPayment(Paymenttoken: String(describing: token), completion: { (response) in
//
//            }, Sendempety:
//                 (send) in
//                if send {
//                self.registerRepo.submitCreditCard(token: token,  completion: { (responsecard) in
//                print(responsecard)
//
//                })
//                }
//            )
            
            
        }
    }
}


