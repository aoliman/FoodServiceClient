//
//  TableViewController.swift
//  FoodServiceProvider
//
//  Created by Index on 1/2/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import UIKit
import PopupDialog
import Localize_Swift
import AlamofireImage
import Kingfisher
import FontAwesome_swift
import Toucan
private let sideMenuCellIdentifier = "sideMenuCellIdentifier"
private let profileInfoCellIdentifier = "profileInfoCellIdentifier"

class SideMenuViewController: UITableViewController, ReloadSideMenuDelegate {
    
    func reloadTableView(_ success: Bool) {
        
        userData = UserDefaults.standard.object(forKey: defaultsKey.userData.rawValue) as? [String: Any]
        user = User(json: userData!)
        self.tableView.reloadData()
    }
    var nvc = UINavigationController()
    var meunItems = ["Home", "Profile", "My Orders","Payment Method","Settings", "Contact Us","About", "Logout"]
    var icons = ["fa-home", "fa-user","fa-list-ol", "fa-credit-card","fa-cog", "fa-phone","fa-info","fa-sign-out"]
    
    var userData = UserDefaults.standard.object(forKey: defaultsKey.userData.rawValue) as? [String: Any]
    var userType = UserDefaults.standard.string(forKey: defaultsKey.userType.rawValue)
    var user: User?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.tableView.register(SideMenuTableViewCell.self, forCellReuseIdentifier: sideMenuCellIdentifier)
        self.tableView.register(ProfileInfoTableViewCell.self, forCellReuseIdentifier: profileInfoCellIdentifier)
        let settingVC = SettingViewController()
        settingVC.delegate = self
        self.tableView.separatorStyle = .none
        user = Singeleton.userInfo
        self.tableView.bounces = false
        self.tableView.alwaysBounceVertical = false
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        self.tableView.backgroundColor = .white
//        self.title = "Back".localized()
        self.navigationDrawerController?.title = "Back".localized()
        self.navigationController?.navigationBar.tintColor = .white
        self.tableView.reloadData()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = self.view.bounds.height
        
        if indexPath.section == 0 {
            return height * 0.25
        }
        else {
            return  (height - (height * 0.25) ) * 0.1
        }
    }
    
    //number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    //header Height
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section != 1) {
            return 0.5
        }
        else {
            return 0
        }
    }
    //----------end header Height---------
    
    
    //header View background color "line seperator for each section"
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.gray
        return headerView
    }
    //----------end header View background color---------
    
    
    //number row in each section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(section == 1) {
            return meunItems.count - 1
        }
        else {
            return 1
        }
    }
    //----------end number row in each section---------
    
    //create custom cell for each row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: profileInfoCellIdentifier)
            return cell!
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: sideMenuCellIdentifier)
            return cell!
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let cell = cell as? ProfileInfoTableViewCell
            cell?.backgroundColor = UIColor.navigationBarColor()
            if let placeImage =  Singeleton.userInfo?.profileImg {
                
                let url = URL(string: (placeImage))
                
                cell?.userImage.convertToCircle()
                cell?.userImage.kf.setImage(with: url, completionHandler: {

                    (image, error, cacheType, imageUrl) in
                    if image != nil {
                        let profileUserImage =  image?.circle
                        cell?.userImage.image =  profileUserImage  //!.circle
                    }
                    else {
                        let profileUserImage =  #imageLiteral(resourceName: "profile") .circle

                        cell?.userImage.image = profileUserImage  //.circle
                    }

                })
            } else {
                
                let profileUserImage =  #imageLiteral(resourceName: "profile") .circle
                cell?.userImage.image = profileUserImage  //.circle

            }
            cell?.userImage.layer.borderWidth = 0
            cell?.nameLabel.text = Singeleton.userName
            cell?.mailLabel.text = Singeleton.userEmail

            guard let online = Singeleton.userInfo?.online else {return}
            
            if online {
                cell?.onlineStatusLabel.isHidden = false
                
            } else {
                cell?.onlineStatusLabel.isHidden = true
            }
        } else {
            let cell = cell as? SideMenuTableViewCell
            cell?.backgroundColor = .white
            
            if indexPath.section == 1 {
                cell?.icon.text = String.fontAwesomeIcon(code: self.icons[indexPath.row])
                cell?.label.text = meunItems[indexPath.row].localized()
            } else if indexPath.section == 2 {
                cell?.icon.text = String.fontAwesomeIcon(code: self.icons.last!)
                cell?.label.text = meunItems.last?.localized()
            }
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if Localize.currentLanguage() == "en" {
            navigationDrawerController?.closeLeftView()
        }
        else {
            navigationDrawerController?.closeRightView()
        }
        if indexPath == [0,0] {
            
//            switch userType {
//
//            case UserType.deliveryPlace.rawValue?:
//                let appToolbarController = AppToolbarController(rootViewController:TopTabsNavigationViewController())
//                appToolbarController.toolbar.title = " ".localized()
//                self.navigationDrawerController?.transition(to: appToolbarController)
//            default:
//                let appToolbarController = AppToolbarController(rootViewController:ProfileVC())
//                self.navigationDrawerController?.transition(to: appToolbarController)
//            }
            
            
        } else if indexPath.section == 1 {
            
            switch meunItems[indexPath.row] {
            case "Home":
                ///
                 let sideMenuViewController = SideMenuViewController()
                if Singeleton.userInfo?.lock == true && ((Singeleton.userInfo) != nil){
                    let    appToolbarController = AppToolbarController(rootViewController: LockViewController())
                    let viewController = AppNavigationDrawerController(rootViewController: appToolbarController, leftViewController: sideMenuViewController)
                    viewController.isHiddenStatusBarEnabled = false
                    self.navigationDrawerController?.transition(to: appToolbarController)
                }else{
                    let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let homeController : HomeVC = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                    
                    let sideMenuViewController = SideMenuViewController()
                    let appToolbarController = AppToolbarController(rootViewController: homeController)
                    appToolbarController.mytitle="Home".localize()
                    if Localize.currentLanguage() == "en" {
                        
                        let viewController = AppNavigationDrawerController(rootViewController: appToolbarController, leftViewController: sideMenuViewController)
                        viewController.isHiddenStatusBarEnabled = false
                        
                        self.navigationDrawerController?.transition(to: appToolbarController)
                        
                    } else {
                        let viewController = AppNavigationDrawerController(rootViewController: appToolbarController, rightViewController: sideMenuViewController)
                        viewController.isHiddenStatusBarEnabled = false
                        self.navigationDrawerController?.transition(to: appToolbarController)
                        
                    }
                    
                }
                
                
                
                
                
            case "Profile":
                 let sideMenuViewController = SideMenuViewController()
                if Singeleton.userInfo?.lock == true && ((Singeleton.userInfo) != nil){
                    let    appToolbarController = AppToolbarController(rootViewController: LockViewController())
                    let viewController = AppNavigationDrawerController(rootViewController: appToolbarController, leftViewController: sideMenuViewController)
                    viewController.isHiddenStatusBarEnabled = false
                    self.navigationDrawerController?.transition(to: appToolbarController)
                }else{
                    var profile = ProfileVC()
                    profile.delegate = self
                    let appToolbarController = AppToolbarController(rootViewController: profile)
                    appToolbarController.mytitle="Profile".localize()
                    appToolbarController.toolbar.title = "Settings".localized()
                    self.navigationDrawerController?.transition(to: appToolbarController)
                }
                
               
                
            case "Payment Method":
                 let sideMenuViewController = SideMenuViewController()
                
                if Singeleton.userInfo?.lock == true && ((Singeleton.userInfo) != nil){
                 var    appToolbarController = AppToolbarController(rootViewController: LockViewController())
                    let viewController = AppNavigationDrawerController(rootViewController: appToolbarController, leftViewController: sideMenuViewController)
                    viewController.isHiddenStatusBarEnabled = false
                    self.navigationDrawerController?.transition(to: appToolbarController)
                    
                }else{
                    let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    
                    let Paymentmethod : Paymentmethod = storyboard.instantiateViewController(withIdentifier: "Paymentmethod") as! Paymentmethod
                    
                    let appToolbarController = AppToolbarController(rootViewController: Paymentmethod )
                    appToolbarController.toolbar.title = "Payment Method".localized()
                    appToolbarController.mytitle="Payment Method".localize()
                    self.navigationDrawerController?.transition(to: appToolbarController)
                    appToolbarController.toolbar.titleLabel.adjustsFontSizeToFitWidth = true
                }
                
                
                
//               // let appToolbarController = AppToolbarController(rootViewController: ProfileVC())
//                let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                let appToolbarController : GetAllProducteAndFilter = storyboard.instantiateViewController(withIdentifier: "GetAllProducteAndFilter") as! GetAllProducteAndFilter
//                appToolbarController.toolbar.title = "Cart".localized()
//                self.navigationDrawerController?.transition(to: appToolbarController)

                
            case "My Orders":
                 let sideMenuViewController = SideMenuViewController()
                
                var appToolbarController = AppToolbarController(rootViewController: LockViewController())
                
                
                if Singeleton.userInfo?.lock == true && ((Singeleton.userInfo) != nil){
                    
                    appToolbarController = AppToolbarController(rootViewController: LockViewController())
                    let viewController = AppNavigationDrawerController(rootViewController: appToolbarController, leftViewController: sideMenuViewController)
                    viewController.isHiddenStatusBarEnabled = false
                    self.navigationDrawerController?.transition(to: appToolbarController)
                    
                }else{
                    let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    
                    let ordersVC :MyOrderAndFilter  = storyboard.instantiateViewController(withIdentifier: "MyOrderAndFilter") as! MyOrderAndFilter
                    
                    let myordersVC :MyOrdersVC  =  MyOrdersVC()
                    
                    
                    //                appToolbarController.toolbar.title = "My Orders".localized()
                    
                    appToolbarController.toolbar.title = "My Orders".localized()
                    appToolbarController.mytitle="My Orders".localize()
                    appToolbarController = AppToolbarController(rootViewController: ordersVC )
                    
                    if Localize.currentLanguage() == "en" {
                        let viewController = AppNavigationDrawerController(rootViewController: appToolbarController, leftViewController: sideMenuViewController)
                        viewController.isHiddenStatusBarEnabled = false
                        self.navigationDrawerController?.transition(to: appToolbarController)
                        
                        
                    } else {
                        let viewController = AppNavigationDrawerController(rootViewController: appToolbarController, rightViewController: sideMenuViewController)
                        viewController.isHiddenStatusBarEnabled = false
                        self.navigationDrawerController?.transition(to: appToolbarController)
                    }
                }
                
                
                
            case "Settings":
                 let sideMenuViewController = SideMenuViewController()
                var appToolbarController = AppToolbarController(rootViewController: SettingViewController())
                if Singeleton.userInfo?.lock == true && ((Singeleton.userInfo) != nil){
                    
                    appToolbarController = AppToolbarController(rootViewController: LockViewController())
                    let viewController = AppNavigationDrawerController(rootViewController: appToolbarController, leftViewController: sideMenuViewController)
                    viewController.isHiddenStatusBarEnabled = false
                    self.navigationDrawerController?.transition(to: appToolbarController)
                    
                }else{
                appToolbarController.toolbar.title = "Settings".localized()
                appToolbarController.mytitle="Settings".localize()
                self.navigationDrawerController?.transition(to: appToolbarController)}

            case "Contact Us":

                let ContactUsVC = ContactUsNavigationTabs()
                let sideMenuViewController = SideMenuViewController()
                var appToolbarController = AppToolbarController(rootViewController: ContactUsVC)
                appToolbarController.mytitle="Contact Us".localize()
                if Singeleton.userInfo?.lock == true && ((Singeleton.userInfo) != nil){
                    
                    appToolbarController = AppToolbarController(rootViewController: LockViewController())
                    let viewController = AppNavigationDrawerController(rootViewController: appToolbarController, leftViewController: sideMenuViewController)
                    viewController.isHiddenStatusBarEnabled = false
                    self.navigationDrawerController?.transition(to: appToolbarController)
                    
                }else{
                if Localize.currentLanguage() == "en" {
                    let viewController = AppNavigationDrawerController(rootViewController: appToolbarController, leftViewController: sideMenuViewController)
                    viewController.isHiddenStatusBarEnabled = false
                    self.navigationDrawerController?.transition(to: appToolbarController)
                   
                } else {
                    let viewController = AppNavigationDrawerController(rootViewController: appToolbarController, rightViewController: sideMenuViewController)
                    viewController.isHiddenStatusBarEnabled = false
                    self.navigationDrawerController?.transition(to: appToolbarController)
                }
            }
            case "About":
                let AboutUsVc = AboutUsViewController()
                let sideMenuViewController = SideMenuViewController()
                var appToolbarController = AppToolbarController(rootViewController: AboutUsVc)
                appToolbarController.mytitle="About".localize()
                
                if Singeleton.userInfo?.lock == true && ((Singeleton.userInfo) != nil){
                    
                    appToolbarController = AppToolbarController(rootViewController: LockViewController())
                    let viewController = AppNavigationDrawerController(rootViewController: appToolbarController, leftViewController: sideMenuViewController)
                    viewController.isHiddenStatusBarEnabled = false
                    self.navigationDrawerController?.transition(to: appToolbarController)
                    
                }else{
                    if Localize.currentLanguage() == "en" {
                        
                        let viewController = AppNavigationDrawerController(rootViewController: appToolbarController, leftViewController: sideMenuViewController)
                        viewController.isHiddenStatusBarEnabled = false
                        self.navigationDrawerController?.transition(to: appToolbarController)
                    } else {
                        
                        let viewController = AppNavigationDrawerController(rootViewController: appToolbarController, rightViewController: sideMenuViewController)
                        viewController.isHiddenStatusBarEnabled = false
                        self.navigationDrawerController?.transition(to: appToolbarController)
                        
                    }
                }
               
               
            default:
                print("")
            }
        }else if indexPath == [2,0] {
        
            
            
            
            let dialogMessage = UIAlertController(title: "Choose Answer".localized(), message: "You Want To Logout".localize(), preferredStyle: .alert)
            
            // Create OK button with action handler
            let ok = UIAlertAction(title: "OK".localize(), style: .default, handler: { (action) in
                print("ok")
                let ref = userRef.child("\(String(describing: (Singeleton.userInfo?.id)!))").child("details")
                ref.updateChildValues(["online" : false])
                
                //logout
                Singeleton.userDefaults.removeObject(forKey: defaultsKey.token.rawValue)
                Singeleton.userDefaults.removeObject(forKey:defaultsKey.isLogged.rawValue )
                Singeleton.userDefaults.removeObject(forKey:defaultsKey.userData.rawValue )
                Singeleton.userDefaults.removeObject(forKey: defaultsKey.userName.rawValue)
                Singeleton.userDefaults.removeObject(forKey: defaultsKey.userPhone.rawValue)
                Singeleton.userDefaults.removeObject(forKey: defaultsKey.userEmail.rawValue)
                Singeleton.userDefaults.removeObject(forKey: defaultsKey.userPassword.rawValue)
//                self.nvc.navigationBar.topItem?.backButton.setTitle("Back".localized(), for: .normal)
                self.nvc = UINavigationController(rootViewController: LoginVc())
                
                self.dismiss(animated: true, completion: nil)
                UIApplication.shared.keyWindow?.rootViewController?.present(self.nvc, animated: true, completion: nil)
                
            })
            let cancel = UIAlertAction(title: "Cancel".localized(), style: .cancel) { (action) -> Void in
                print("cancel")
            }

           
            dialogMessage.addAction(ok)
             dialogMessage.addAction(cancel)
            self.present(dialogMessage, animated: true, completion: nil)
                
                    
                    
                
                    
                    
            
                
                
                
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        
        if indexPath.section != 0 {
            tableView.cellForRow(at: indexPath)?.backgroundColor = UIColor.init(hex: "e9e9e9")
            let cell = tableView.cellForRow(at: indexPath) as? SideMenuTableViewCell
            cell?.label.textColor = .navigationBarColor()
            cell?.icon.textColor = .navigationBarColor()
        }
    }
    
    override func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        if indexPath.section != 0 {
            tableView.cellForRow(at: indexPath)?.backgroundColor = .white
            let cell = tableView.cellForRow(at: indexPath) as? SideMenuTableViewCell
            cell?.label.textColor = .black
            cell?.icon.textColor = .black
        }
        
    }
}



