//
//  EditPasswordFile.swift
//  FoodServiceClient
//
//  Created by index-ios on 4/30/18.
//  Copyright © 2018 Index. All rights reserved.
//

import UIKit
import Material
import Localize_Swift
class EditPasswordFile: UIView {

    @IBOutlet weak var Oldpassword: ErrorTextField!
    @IBOutlet weak var NewPassword: ErrorTextField!
    @IBOutlet weak var Btnok: UIButton!
    @IBOutlet weak var ConfiremPassword: ErrorTextField!
    override init(frame: CGRect) {
        super.init(frame: frame)
       // SetupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        SetupView()
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

}
