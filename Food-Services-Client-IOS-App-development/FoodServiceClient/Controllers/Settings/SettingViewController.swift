//
//  SettingViewController.swift
//  FoodServiceProvider
//
//  Created by Index on 2/24/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import UIKit
import FontAwesome_swift
import PopupDialog

private let settingCellIdentifier = "settingCellIdentifier"
private let sectionHeader = "sectionHeader"

class SettingViewController: UIViewController{
    
   
    weak var delegate: ReloadSideMenuDelegate?

    let sideMenuVC = SideMenuViewController()

    lazy var settingRepo = SettingRepo()
    

    var collectionView: UICollectionView = UICollectionView(frame: CGRect(),collectionViewLayout: UICollectionViewFlowLayout())
    var sections = ["ProfileSetting", "GeneralSetting"]
   

    var profileSettingIcons = ["fa-user-circle", "fa-envelope", "fa-phone", "fa-lock"]
   // "Name", "Email", "Mobile", "changePassword"
    var profileSetting : [String] = []
    var profileValues: [String?] = []

    var generalSettingIcons = ["fa-globe", "fa-bell", "fa-comments-o", "fa-credit-card"]
    var generalSetting = ["Language", "Notification", "Chat Activity", "Payment Methods"]
    var currentLanguage: String?
    
    var user: User?
    var currentPassword = ""
    var newPassword = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(collectionView)
        
        collectionView.backgroundColor = .white
        setupView()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.collectionView.register(SettingCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader , withReuseIdentifier: sectionHeader)
        
        self.collectionView.register(SettingCollectionViewCell.self, forCellWithReuseIdentifier: settingCellIdentifier)
        
        collectionView.snp.makeConstraints {
            make in
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.top.equalTo(self.view.snp.top).offset(0)
            make.bottom.equalTo(self.view.snp.bottom)
        }
        
        user = Singeleton.userInfo
        profileValues = [Singeleton.userName, Singeleton.userEmail, Singeleton.userPhone, "Password"]
        
        currentLanguage = UserDefaults.standard.string(forKey: defaultsKey.language.rawValue)
        UserDefaults.standard.synchronize()
        
        hideKeyboardWhenTappedAround()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
 
extension SettingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: sectionHeader, for: indexPath) as! SettingCollectionReusableView
        headerView.backgroundColor = UIColor.init(hex: "e9e9e9")
        headerView.label.setAlignment()
        if indexPath.section == 0 {
            headerView.label.text = sections[indexPath.section].localized()
        } else if indexPath.section == 1 {
            headerView.label.text = sections[indexPath.section].localized()
        } else  {
            headerView.label.text = sections[indexPath.section].localized()
        }
        return headerView
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let  width  = Double(UIScreen.main.bounds.width)
        if(section == 0){
            
          return CGSize(width: width - 15, height: 0)
        }else{
            
            if UIDevice.current.model == "iPad" {
                return CGSize(width: width - 15, height: 60)
                
            } else {
                return CGSize(width: width - 15, height: 40)
                
            }
        }
        
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return profileSetting.count
        } else if section == 1 {
            return generalSetting.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        
       

        return UIEdgeInsetsMake(0, 0, 10, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        var  width  = Double(UIScreen.main.bounds.width)
        
        width =  (width - 20)
        if indexPath == [1, generalSetting.count - 1] {
            return CGSize.init(width: width , height: 120)
        }
        return CGSize.init(width: width , height: 50)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
   
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: settingCellIdentifier, for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = cell as? SettingCollectionViewCell
        
        if indexPath.section == 0 {
            
            cell?.generalSetting.isHidden = true
            cell?.value.isErrorRevealed = false
            cell?.button.isHidden = false
            cell?.icon.text = String.fontAwesomeIcon(code: profileSettingIcons[indexPath.row])
            cell?.label.text = profileSetting[indexPath.row].localized()
            cell?.value.addIconButton("fa-check-circle", .navigationBarColor(), (cell?.button)!)
            cell?.value.placeholder = profileValues[indexPath.row]

            if indexPath.row == profileValues.count - 1 {
                cell?.value.isSecureTextEntry = true
                cell?.value.isUserInteractionEnabled = false
                cell?.value.placeholder = profileValues[indexPath.row]?.localized()

            }
            
            cell?.button.tag = indexPath.row
            cell?.value.tag = indexPath.row
            cell?.value.delegate = self

        } else if indexPath.section == 1 {
            
            cell?.value.isUserInteractionEnabled = false
            cell?.generalSetting.isUserInteractionEnabled = false
            cell?.value.isHidden = true
            
            if indexPath.row == 0 {
                
                cell?.generalSetting .text = currentLanguage?.localized()
                cell?.icon.text = String.fontAwesomeIcon(code: generalSettingIcons[indexPath.row])
                cell?.label.text = generalSetting[indexPath.row].localized()
            } else if indexPath.row == generalSetting.count - 1  {
            
                cell?.label.text = generalSetting[indexPath.row].localized()
                cell?.icon.text = String.fontAwesomeIcon(code: generalSettingIcons[indexPath.row])
                cell?.visaIcon.isHidden = false
                cell?.cashIcon.isHidden = false
                cell?.payPalIcon.isHidden = false
            } else {

                cell?.icon.text = String.fontAwesomeIcon(code: generalSettingIcons[indexPath.row])
                cell?.label.text = generalSetting[indexPath.row].localized()
                cell?.switchButton.isHidden = false
                if indexPath.row == 2 {
                    cell?.setupOnlineButton(cell)
                } else if indexPath.row == 1 {
                    cell?.setupNotificationButton(cell)
                }
            }
        }
        cell?.button.setTitleColor(.cardColor(), for: .normal)

    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            
            if indexPath.row == profileSetting.count - 1 {
                
                let changePasswordVC = ChangePasswordVC()
                
                let cell = collectionView.cellForItem(at: indexPath) as? SettingCollectionViewCell

               
                let popup = PopupDialog.init(viewController: changePasswordVC, completion: { [weak self] in
                    
                    self?.currentPassword = changePasswordVC.oldPasswordTextField.text!
                    self?.newPassword = changePasswordVC.newPasswordTextField.text!
                    
                    if changePasswordVC.newPasswordTextField.text != changePasswordVC.confirmPasswordTextField.text || (changePasswordVC.newPasswordTextField.text?.isEmpty)! {
                        
                        cell?.button.setTitleColor(.cardColor(), for: .normal)

                    } else {
                        cell?.value.text = self?.newPassword
                        cell?.button.setTitleColor(.navigationBarColor(), for: .normal)
                        cell?.button.addTarget(self, action: #selector(self?.editPtofile), for: .touchUpInside)

                    }
                   
                })
                
                // Create buttons
                let cancelButton = CancelButton(title: "Cancel".localized()) {
                }
                
                // This button will not the dismiss the dialog
                let saveButton = DefaultButton(title: "Save".localized(), dismissOnTap: true) {
                    guard let oldPassword = changePasswordVC.oldPasswordTextField.text else {
                        return
                    }
                    
                    guard let newPassword = changePasswordVC.newPasswordTextField.text else {
                        return
                    }
                    
                    guard let confirmNewPassword = changePasswordVC.confirmPasswordTextField.text else {
                        return
                    }
                    
                    if newPassword != confirmNewPassword {
                        DataUtlis.data.WarningDialog(Title: "FailedTitle".localized(), Body: "PasswordAndConfirmPassword".localized())
                    } else if Singeleton.userPassword != oldPassword {
                        DataUtlis.data.WarningDialog(Title: "FailedTitle".localized(), Body: "oldPasswordWrong".localized())
                    } else {
                        self.currentPassword = oldPassword
                        self.newPassword = newPassword
                        let sender = UIButton()
                        sender.tag = 5
                        self.editPtofile(sender)
                    }
                    
                    
                }
                	
                saveButton.titleColor = .appColor()
                saveButton.titleFont = UIFont.appFont(ofSize: 14)
                cancelButton.titleFont = UIFont.appFont(ofSize: 14)
                popup.addButtons([cancelButton, saveButton])
                popup.buttonAlignment = .horizontal

                self.present(popup, animated: true, completion: {
                    cell?.button.setTitleColor(.navigationBarColor(), for: .normal)
                })
                
                
            }
            
        } else if indexPath.section == 1 {
            
            if indexPath.row == 0 {
                
                let popup = PopupDialog.init(viewController: ChangeLanguageVC())
                self.present(popup, animated: true, completion: nil)
                
            }
        }
    }
}

extension SettingViewController :UITextFieldDelegate {

    func setupButton(_ textField: UITextField) {
        
        guard let cell = textField.superview as? SettingCollectionViewCell else {
            return
        }
        
        cell.button.addTarget(self, action: #selector(editPtofile), for: .touchUpInside)
        cell.button.setTitleColor(.navigationBarColor(), for: .normal)
        cell.button.setTitle(String.fontAwesomeIcon(code: "fa-check-circle"), for: .normal)
        self.delegate?.reloadTableView(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
       
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let cell = textField.superview as? SettingCollectionViewCell else {
            return // or fatalError() or whatever
        }

        if !(textField.text?.isEmpty)! {

            if textField.tag == 0 {
                
                if isValidName(str: textField.text!) {
                    Singeleton.userDefaults.set(textField.text, forKey: defaultsKey.userName.rawValue)
                    Singeleton.userDefaults.synchronize()

                    setupButton(textField)
                    
                } else {
                    cell.value.detail = "Should contain at least one character".localized()

                }
                cell.value.isErrorRevealed = !isValidName(str: textField.text!)

            }
            else if textField.tag == 1 {
                if isValidMail(str: textField.text!) {
                    
                    Singeleton.userDefaults.set(textField.text, forKey: defaultsKey.userEmail.rawValue)
                    Singeleton.userDefaults.synchronize()
                    setupButton(textField)
                } else {
                    cell.value.detail = "please enter valid mail".localized()

                }
                cell.value.isErrorRevealed = !isValidMail(str: textField.text!)

            }
            else if textField.tag == 2 {

                    Singeleton.userDefaults.set(textField.text, forKey: defaultsKey.userPhone.rawValue)
                    Singeleton.userDefaults.synchronize()
                    setupButton(textField)

            }
            else if textField.tag == 3 {
                
                setupButton(textField)

            }
        }
        
    }
    
    func isValidName (str: String) -> Bool {
        
        let nameRegEx = ".*[a-zA-Z]+.*"
        let nameTest = NSPredicate(format: "SELF MATCHES %@", nameRegEx)
        return nameTest.evaluate(with: str)
        
    }
    
    func isValidMail (str: String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: str)
    }
}

extension SettingViewController  {

    @objc func editPtofile(_ sender: UIButton) {
        
        guard let cell = sender.superview as? SettingCollectionViewCell else {
            return // or fatalError() or whatever
        }
        
        if !(cell.value.text?.isEmpty)! {
            settingRepo.editProfile(name: Singeleton.userName, email: Singeleton.userEmail, phone: Singeleton.userPhone, currentPassword:  self.currentPassword, newPassword: self.newPassword, onSuccess: { [weak self] (user, statusCode) in
                switch statusCode {
                    
                case StatusCode.complete.rawValue:
                    cell.button.setTitleColor(.appGreenColor(), for: .normal)
              
                    self?.delegate?.reloadTableView(true)
                    
                case StatusCode.success.rawValue:
                    cell.button.setTitleColor(.appGreenColor(), for: .normal)
                    self?.delegate?.reloadTableView(true)
                    
                default:
                    cell.button.setTitleColor(.refusedColor(), for: .normal)
                    
                    cell.button.setTitle(String.fontAwesomeIcon(code: "fa-times-circle"), for: .normal)
                    
                    let indexPath = self?.collectionView.indexPath(for: cell)
                    cell.value.isErrorRevealed = true
                    
                    if indexPath?.row == 0  {
                        cell.value.detail = "please enter valid name".localized()
                    } else if indexPath?.row == 1 {
                        cell.value.detail = "please enter valid mail".localized()
                    } else if indexPath?.row == 2 {
                        cell.value.detail = "please enter valid phone".localized()
                    } else if indexPath?.row == 3 {
                        
                    }
                    
                    self?.user = Singeleton.userInfo
                    self?.delegate?.reloadTableView(true)
                }
                }, onFailure: { (errorResponse, statusCode) in
                    if let errorMessage = errorResponse?.error[0].msg {
                    DataUtlis.data.WarningDialog(Title: "Error".localized(), Body: errorMessage)
                    }

            })
//            settingRepo.editProfile(name: (self.user?.name)!, email: (self.user?.email)!, phone: (self.user?.phone)!, currentPassword: self.currentPassword, newPassword: self.newPassword, onSuccess: <#SettingRepo.EditProfileHandler#>) { [weak self] (user, statusCode) in
//
//
//                switch statusCode {
//
//                    case StatusCode.complete.rawValue:
//                        cell.button.setTitleColor(.appGreenColor(), for: .normal)
//                        UserDefaults.standard.setValue(self?.user?.toJSON(), forKey: defaultsKey.userData.rawValue)
//                        UserDefaults.standard.synchronize()
//                        self?.delegate?.reloadTableView(true)
//
//                    default:
//                        cell.button.setTitleColor(.refusedColor(), for: .normal)
//
//                        cell.button.setTitle(String.fontAwesomeIcon(code: "fa-times-circle"), for: .normal)
//
//                        let indexPath = self?.collectionView.indexPath(for: cell)
//                        cell.value.isErrorRevealed = true
//
//                        if indexPath?.row == 0  {
//                            cell.value.detail = "please enter valid name".localized()
//                        } else if indexPath?.row == 1 {
//                            cell.value.detail = "please enter valid mail".localized()
//                        } else if indexPath?.row == 2 {
//                            cell.value.detail = "please enter valid phone".localized()
//                        } else if indexPath?.row == 3 {
//
//                        }
//
//                        self?.user = User(json: (self?.userData!)!)
//
//                    }
//                }
            
        }
        else {
            cell.button.setTitleColor(.refusedColor(), for: .normal)
            cell.button.setTitle(String.fontAwesomeIcon(code: "fa-exclamation-circle"), for: .normal)
        }
    }
}


protocol ReloadSideMenuDelegate: class {
    
    func reloadTableView(_ success: Bool) // change user information in side meun after editing succesfull
    
}
