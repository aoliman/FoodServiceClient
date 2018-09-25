//
//  InfoCell.swift
//  FoodServiceClient
//
//  Created by index-ios on 4/25/18.
//  Copyright © 2018 Index. All rights reserved.
//

import UIKit
import Material
import SkyFloatingLabelTextField
import Localize_Swift
class ProfileInfoCell: UITableViewCell{

    @IBOutlet weak var Password: ErrorTextField!
    @IBOutlet weak var Username: ErrorTextField!
    @IBOutlet weak var Phonenumber: ErrorTextField!
    @IBOutlet weak var topimageconstrain: NSLayoutConstraint!
    @IBOutlet weak var topstackconstrain: NSLayoutConstraint!
    @IBOutlet weak var ProfileImage: UIImageView!
    
    @IBOutlet weak var BtnEditPasword: UIButton!
    
    /////image controller
    var controller = UIImagePickerController()
    var tapGestureRecognizer = UITapGestureRecognizer()
     var prfileres = ProfileRespository()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        SetupView()
        
    }
    
    
    @IBAction func PasswordTouchin(_ sender: Any) {
        Password.text = ""
    }

    func SetupView(){
        
        if Localize.currentLanguage() == "en"{
            Password.semanticContentAttribute = .forceLeftToRight
            Username.semanticContentAttribute = .forceLeftToRight
            Phonenumber.semanticContentAttribute = .forceLeftToRight
            Password.textAlignment = .left
            Username.textAlignment = .left
            Phonenumber.textAlignment = .left
        }else{
            Password.semanticContentAttribute = .forceRightToLeft
            Username.semanticContentAttribute = .forceRightToLeft
            Phonenumber.semanticContentAttribute = .forceRightToLeft
            Password.textAlignment = .right
            Username.textAlignment = .right
            Phonenumber.textAlignment = .right
        }
        
        
        //add controller image delegate and type
        tapGestureRecognizer.delegate=self
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        
        ProfileImage.isUserInteractionEnabled = true
        ProfileImage.addGestureRecognizer(tapGestureRecognizer)
       // controller.delegate=self
        controller.sourceType = .photoLibrary
        
        
        
       
        
        
        
        /////
        Password.isSecureTextEntry = true
        Password.text = "**********"
        topimageconstrain.constant=self.layer.frame.height*2.8/100
        topstackconstrain.constant=self.layer.frame.height*1.5/100
       
       SetupTextField(fieldtext: Username, placeholder: "User Name".localize(), errortext: "Invalid UserName".localize())
        SetupTextField(fieldtext: Phonenumber, placeholder: "Phone Number".localize(), errortext: "Phone Number".localize())
         SetupTextField(fieldtext: Password, placeholder: "Password".localize(), errortext: "Invalid Password ( 1 uppercase & 1 digitat & 1 owercase & 8 characters total)".localize())
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
    func GetHight(percentage :Double) ->Double {
        let height=Double(self.layer.frame.height)*percentage/100
        return height
    }
    
    
    
    // image action to upload image
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        
        //        self.navigationController?.pushViewController(EditProfileVc(), animated: false)
         // present(controller, animated: true, completion: nil)
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedimage = info[UIImagePickerControllerOriginalImage] as! UIImage
        ProfileImage.image?=selectedimage.circle
        
        let  uploadimage = UIImageJPEGRepresentation(selectedimage, 0.25)
        print(uploadimage)
        prfileres.UpdateProfileImage(id:(Singeleton.userInfo?.id)! , image:uploadimage! ) { (client) in
            Singeleton.userDefaults.set(client.toJSON(), forKey: defaultsKey.userData.rawValue)
            print(Singeleton.userInfo?.toJSON())
            Singeleton.userDefaults.synchronize()
           
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
    

}

