//
//  EditProfile.swift
//  FoodServiceClient
//
//  Created by index-ios on 4/25/18.
//  Copyright © 2018 Index. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
protocol Reloadtableviewdeleget {
    func ReloadData()
}
class EditProfile: UIViewController {

    
    @IBOutlet weak var MyTableView: UITableView!
    var deleget:Reloadtableviewdeleget?
    /////image controller
    var controller = UIImagePickerController()
    var tapGestureRecognizer = UITapGestureRecognizer()
    var tapGestureRecognizerPassword = UITapGestureRecognizer()
    var prfileres = ProfileRespository()
    var cellinfo : ProfileInfoCell?
    lazy var settingRepo = SettingRepo()
    lazy var repo = UserRepository()
    var newpassword : String?
    var currentpassword : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupView()
        
      
    }

    func SetupView(){
        setupNavigationBar()
        self.title = "Edite Profile".localized()
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.backBarButtonItem?.title = "Back".localized()
        MyTableView.delegate=self
        MyTableView.dataSource=self
        
        //add controller image delegate and type
        tapGestureRecognizer.delegate=self
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        tapGestureRecognizerPassword.delegate = self
        tapGestureRecognizerPassword = UITapGestureRecognizer(target: self, action: #selector(BtnEditPassword))
        controller.delegate=self
        controller.sourceType = .photoLibrary
     }
  
    @objc func BtnDoneAction() {
    cellinfo = MyTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! ProfileInfoCell
        newpassword = Singeleton.userPassword
        currentpassword = Singeleton.userPassword
        
        if(cellinfo?.Username.text == "" || cellinfo?.Username.text == nil ){
            UIApplication.shared.keyWindow?.rootViewController?.view.makeToast("Enter UserName".localized())
        }
        if(cellinfo?.Phonenumber.text == "" || cellinfo?.Phonenumber.text == nil ){
            UIApplication.shared.keyWindow?.rootViewController?.view.makeToast("Enter Phone Number".localized())
        }
         if(( UserDefaults.standard.string(forKey: "NewPassword")) != nil && (UserDefaults.standard.string(forKey: "NewPassword")?.isEmpty)! != true ){
           // print(UserDefaults.standard.string(forKey: "NewPassword")!)
            newpassword = UserDefaults.standard.string(forKey: "NewPassword")!
            
            
        }
         if DataUtlis.data.isInternetAvailable() {
          myLoader.showCustomLoaderview(uiview: self.view)
            editeprofilesend()
            
         }else{
            DataUtlis.data.WarningDialog(Title: "FailedTitle".localized(), Body: "NoInternet".localized())
            myLoader.hideCustomLoader()
        }
     


    }
    
    @objc func BtnEditPassword(){
        let customInfoWindow = Bundle.main.loadNibNamed("EditPasswordConfirm", owner: self, options: nil)![0] as! EditPasswordFile
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let passController : PopUpMenuPassword = storyboard.instantiateViewController(withIdentifier: "PopUpMenuPassword") as! PopUpMenuPassword
      
          passController.modalPresentationStyle = .custom
        passController.modalTransitionStyle = .crossDissolve
        present(passController, animated: false, completion: nil)
    }

}
extension EditProfile : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0 ) {
            let cell : ProfileInfoCell = MyTableView.dequeueReusableCell(withIdentifier: "ProfileInfoCell", for: indexPath) as! ProfileInfoCell
            let url = URL(string: (Singeleton.userInfo?.profileImg)!)
            cell.ProfileImage.kf.setImage(with: url, completionHandler: {
                (image, error, cacheType, imageUrl) in
                cell.ProfileImage.image =  image?.circle
            })
            cell.ProfileImage.isUserInteractionEnabled = true
            cell.ProfileImage.addGestureRecognizer(tapGestureRecognizer)
            cell.Phonenumber.text = Singeleton.userPhone
            cell.Username.text = Singeleton.userName
            cell.BtnEditPasword.addTarget(self, action: #selector(BtnEditPassword), for: .touchUpInside)
            cell.Password.addGestureRecognizer(tapGestureRecognizerPassword)
            return cell
        }
        else {
            //UIGestureRecognizerDelegate
            let cell : ProfileMapCell = MyTableView.dequeueReusableCell(withIdentifier: "ProfileMapCell", for: indexPath) as! ProfileMapCell
            
            cell.BtnSure.addTarget(self, action: #selector(BtnDoneAction) , for: .touchUpInside)
//            cell.BtnCreditcard.addTarget(self, action: #selector(), for: .touchUpInside)
            
            return cell
            
        }
       
    }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 0){
            return UIScreen.main.bounds.height*50/100
        }
        else if(indexPath.row == 1){
            return (UIScreen.main.bounds.height*75/100)
        }
            
            
            
            
            
        else {
            return UIScreen.main.bounds.height*35/100
        }
    }
    
    
}

extension EditProfile: UIImagePickerControllerDelegate ,UINavigationControllerDelegate , UIGestureRecognizerDelegate {
    
    
    
    
    
    // image action to upload image
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        present(controller, animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedimage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let cell : ProfileInfoCell = MyTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! ProfileInfoCell
        
       // print(selectedimage)
        cell.ProfileImage.image?=selectedimage.circle
        
       
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    ///editprofile
    func editeprofilesend(){
        let cell : ProfileInfoCell = MyTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! ProfileInfoCell
        print("current \(self.currentpassword!)")
        print("new \(self.newpassword) ")
        settingRepo.editProfile(name: cell.Username.text!, email: Singeleton.userEmail, phone: cell.Phonenumber.text!, currentPassword: currentpassword!, newPassword:newpassword!, onSuccess: { [weak self] (user, statusCode) in
                switch statusCode {
                    
                case StatusCode.complete.rawValue:
                    self?.EditEnd(user: user)
              
                    
                    
                case StatusCode.success.rawValue:  self?.EditEnd(user: user)
                 
                    
                default: break
                   
                  
                    
                    
                }
                }, onFailure: { (errorResponse, statusCode) in
                    if let errorMessage = errorResponse?.error[0].msg {
                        DataUtlis.data.WarningDialog(Title: "Error".localized(), Body: errorMessage)
                    }
                    
            })
           
            
        
    
    }
    func EditEnd(user : EditProfileResponse){
        
        Singeleton.userDefaults.set(self.newpassword!  , forKey:defaultsKey.userPassword.rawValue)
        Singeleton.userDefaults.set(user.token, forKey: defaultsKey.token.rawValue)
        Singeleton.userDefaults.set(user.user.id, forKey: defaultsKey.userId.rawValue)
        Singeleton.userDefaults.set(user.user.toJSON(), forKey: defaultsKey.userData.rawValue)
        Singeleton.userDefaults.set(user.user.name, forKey: defaultsKey.userName.rawValue)
        Singeleton.userDefaults.set(user.user.phone, forKey: defaultsKey.userPhone.rawValue)
        Singeleton.userDefaults.set(user.user.email, forKey: defaultsKey.userEmail.rawValue)
        
        UserDefaults.standard.removeObject(forKey: "NewPassword")
        UserDefaults.standard.removeObject(forKey: "CurrentPassword")
        Singeleton.userDefaults.synchronize()
        // upload image
        let  uploadimage = UIImageJPEGRepresentation((cellinfo?.ProfileImage.image!)!, 1)
        prfileres.UpdateProfileImage(id:(Singeleton.userInfo?.id)! , image:uploadimage! ) { (client) in
                    Singeleton.userDefaults.set(client.toJSON(), forKey: defaultsKey.userData.rawValue)
            let  cellmap : ProfileMapCell = self.MyTableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! ProfileMapCell
            if( cellmap.arrayCoordinates.count != 0 ){
                
                self.Editlocation(lat:cellmap.arrayCoordinates[0].latitude, lan: cellmap.arrayCoordinates[0].longitude )
                
            }else{
                 Loader.hideLoader()
                Singeleton.userDefaults.synchronize()
                self.deleget?.ReloadData()
                self.motionDismissViewController()
            }
         
                    }
        
    }
    func Editlocation(lat : Double , lan : Double ){
       
        
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
      repo.determineLocation(id: Singeleton.userId!, lat: lat, lan: lan, onSuccess: { (response, statusCode) in
        Singeleton.userDefaults.set(response?.user.toJSON(), forKey: defaultsKey.userData.rawValue)
    
                    Loader.hideLoader()
                    Singeleton.userDefaults.synchronize()
                    self.deleget?.ReloadData()
                    self.motionDismissViewController()
                    
                    
                }, onFailure: { (errorResponse, statusCode) in
                    
                    Loader.hideLoader()
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    let errorMessage = errorResponse?.error[0].msg
                    DataUtlis.data.WarningDialog(Title: "Error".localized(), Body: errorMessage!)
                    
                })
                
          
            
        
    }
    //
    func EditCreditcard(){
        let vc = CreditCardVc ()
        vc.Isedite = true
        self.navigationController?.pushViewController(vc, animated: true)
    }

    
    
    
}
