//
//  PopUpMenuPassword.swift
//  FoodServiceClient
//
//  Created by index-ios on 4/30/18.
//  Copyright © 2018 Index. All rights reserved.
//

import UIKit
import Material
import Localize_Swift
class PopUpMenuPassword: UIViewController {
    @IBOutlet weak var Oldpassword: ErrorTextField!
    @IBOutlet weak var NewPassword: ErrorTextField!
    @IBOutlet weak var Btnok: UIButton!
    @IBOutlet weak var ConfiremPassword: ErrorTextField!
    @IBOutlet weak var BackView: UIView!
    @IBOutlet weak var MenuView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         SetupView()
 BackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
       
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        SetupView()
    }
    
    
    @IBAction func BtnDoneAction(_ sender: Any) {
        if(Oldpassword.text == "" || Oldpassword.text == nil ){
UIApplication.shared.keyWindow?.rootViewController?.view.makeToast("Enter current Password".localized())
        }else if(NewPassword.text == "" || NewPassword.text == nil ){
UIApplication.shared.keyWindow?.rootViewController?.view.makeToast("Enter New Password".localized())
        }else if(ConfiremPassword.text == "" || ConfiremPassword.text == nil ){
UIApplication.shared.keyWindow?.rootViewController?.view.makeToast("Enter Confirem Password".localized())
        }else if(ConfiremPassword.text != NewPassword.text  ){
 UIApplication.shared.keyWindow?.rootViewController?.view.makeToast("New Password Not Equale Confilem Password".localized())
        }else if(Oldpassword.text != Singeleton.userPassword ){
            Oldpassword.dividerColor=#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            Oldpassword.dividerActiveColor=#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            UIApplication.shared.keyWindow?.rootViewController?.view.makeToast("çurrent  Password is Incorrect".localized())
        }
        else{
            UserDefaults.standard.set(NewPassword.text, forKey: "NewPassword")
            UserDefaults.standard.set(Oldpassword.text, forKey: "CurrentPassword")
            dismiss(animated: true)
        }
        
       
    }
    
    func SetupView(){
        
        if Localize.currentLanguage() == "en"{
            Oldpassword.semanticContentAttribute = .forceLeftToRight
            NewPassword.semanticContentAttribute = .forceLeftToRight
            ConfiremPassword.semanticContentAttribute = .forceLeftToRight
            Oldpassword.textAlignment = .left
            NewPassword.textAlignment = .left
            ConfiremPassword.textAlignment = .left
        }else{
            Oldpassword.semanticContentAttribute = .forceRightToLeft
            NewPassword.semanticContentAttribute = .forceRightToLeft
            ConfiremPassword.semanticContentAttribute = .forceRightToLeft
            Oldpassword.textAlignment = .right
            NewPassword.textAlignment = .right
            ConfiremPassword.textAlignment = .right
        }
        
        
        MenuView.layer.cornerRadius = 70
        
        
        
        Btnok.setTitle("Done".localized(), for: .normal )
        Btnok.layer.cornerRadius = 10
        MenuView.cornerRadiusPreset = CornerRadiusPreset(rawValue: 8)!
        MenuView.layer.cornerRadius = 16
        MenuView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        MenuView.layer.shadowOpacity = 1
        MenuView.layer.shadowOffset = CGSize(width: 20, height: 20)
        MenuView.layer.shadowRadius = 5
        MenuView.layer.shadowPath = UIBezierPath(rect: MenuView.bounds).cgPath
        MenuView.layer.shouldRasterize = true
        MenuView.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
        
        //add shadow for view
        var  shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: MenuView.bounds, cornerRadius: 10).cgPath
        shadowLayer.fillColor = UIColor.white.cgColor
        
        shadowLayer.shadowColor = UIColor.darkGray.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        shadowLayer.shadowOpacity = 0.5
        shadowLayer.shadowRadius = 2
        
        MenuView.layer.insertSublayer(shadowLayer, at: 0)
        
        /////
        Oldpassword.isSecureTextEntry = true
        NewPassword.isSecureTextEntry = true
        ConfiremPassword.isSecureTextEntry = true
        
        SetupTextField(fieldtext: ConfiremPassword, placeholder: "Confirm Password".localize(), errortext: "".localize())
        SetupTextField(fieldtext: Oldpassword, placeholder: "Old Password".localize(), errortext: " ".localize())
        SetupTextField(fieldtext: NewPassword, placeholder: "New Password".localize(), errortext: " ".localize())
    }
    
    func SetupTextField(fieldtext : ErrorTextField ,placeholder :String , errortext :String){
        fieldtext.placeholder = placeholder.localize()
        fieldtext.detail = errortext.localize()
        fieldtext.placeholderActiveColor=#colorLiteral(red: 0, green: 0.5928431153, blue: 0.6563891768, alpha: 0.8477172852)
        fieldtext.placeholderNormalColor=#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        fieldtext.dividerColor=#colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
        fieldtext.dividerActiveColor=#colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
        fieldtext.dividerColor=#colorLiteral(red: 0, green: 0.5928431153, blue: 0.6563891768, alpha: 0.8477172852)
        fieldtext.dividerNormalHeight=2
        fieldtext.dividerActiveHeight=3
        fieldtext.placeholderVerticalOffset = 35
        
        fieldtext.placeholderActiveScale = 1
        fieldtext.detailVerticalOffset = -2
        
        fieldtext.dividerNormalColor=#colorLiteral(red: 0, green: 0.5928431153, blue: 0.6563891768, alpha: 0.8477172852)
        
        
    }
    @objc func didTappedOnBackgroundView(){
        dismiss(animated: true)
    }

   

}
