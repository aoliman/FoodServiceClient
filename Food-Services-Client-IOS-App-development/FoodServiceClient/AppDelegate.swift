//
//  AppDelegate.swift
//  FoodServiceClient
//
//  Created by Index on 3/1/18.
//  Copyright © 2018 Index. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps
import Localize_Swift
import Material
import Cosmos

import  IQKeyboardManagerSwift
import DropDown
import GooglePlaces
import Firebase
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static var instance: AppDelegate!
    var currentLanguage: String?
    var nvc = UINavigationController()
    var orientationLock = UIInterfaceOrientationMask.all
    var Getallproducterepo = GetallProdacteRepo()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        GMSPlacesClient.provideAPIKey(Google_Map_Key)
//        GMSServices.provideAPIKey(Google_Map_Key)
        
        
        //firebase configration
        FirebaseApp.configure()
        
        GMSPlacesClient.provideAPIKey(MapKey)
        GMSServices.provideAPIKey(MapKey)
        AppDelegate.instance = self
       
    // To tell dropdown to appen above keyboard
         DropDown.startListeningToKeyboard()
         UserDefaults.standard.set(0, forKey: ShowMore)
 changeIntialViewController()

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}
extension AppDelegate {
    func setupLanguage() {        //set app language for first installastion according to device
        //Define profileType
        UserDefaults.standard.set( 0 , forKey: Type)
        UserDefaults.standard.synchronize()
        ///////////////////////////
        currentLanguage = UserDefaults.standard.string(forKey: defaultsKey.language.rawValue)
        
        if currentLanguage == nil {
            UserDefaults.standard.set(Localize.currentLanguage(), forKey: defaultsKey.language.rawValue)
            UserDefaults.standard.synchronize()
        }
        else {
            Localize.setCurrentLanguage(currentLanguage!)
            
            if Localize.currentLanguage() == "en" {
                UIView.appearance().semanticContentAttribute = .forceLeftToRight
                UILabel.appearance().semanticContentAttribute = .forceLeftToRight
                UITextField.appearance().semanticContentAttribute = .forceLeftToRight
                UINavigationBar.appearance().semanticContentAttribute = .forceLeftToRight
                ErrorTextField.appearance().semanticContentAttribute = .forceLeftToRight
                TextField.appearance().semanticContentAttribute = .forceLeftToRight
                FlatButton.appearance().semanticContentAttribute = .forceLeftToRight
                UIButton.appearance().semanticContentAttribute = .forceLeftToRight
                UITableView.appearance().semanticContentAttribute = .forceLeftToRight
                UICollectionView.appearance().semanticContentAttribute = .forceLeftToRight
                CosmosView.appearance().semanticContentAttribute = .forceLeftToRight
                
            }else {
                UIView.appearance().semanticContentAttribute = .forceRightToLeft
                UILabel.appearance().semanticContentAttribute = .forceRightToLeft
                UITextField.appearance().semanticContentAttribute = .forceRightToLeft
                UINavigationBar.appearance().semanticContentAttribute = .forceRightToLeft
                ErrorTextField.appearance().semanticContentAttribute = .forceRightToLeft
                TextField.appearance().semanticContentAttribute = .forceRightToLeft
                FlatButton.appearance().semanticContentAttribute = .forceRightToLeft
                UIButton.appearance().semanticContentAttribute = .forceRightToLeft
                UITableView.appearance().semanticContentAttribute = .forceRightToLeft
                UICollectionView.appearance().semanticContentAttribute = .forceRightToLeft
                CosmosView.appearance().semanticContentAttribute = .forceRightToLeft
                
                
            }
        }
        
    }
    
    
    func changeIntialViewController() {
        UIApplication.shared.statusBarView?.backgroundColor = UIColor.appColor()
        setupLanguage()
        self.window = UIWindow(frame: UIScreen.main.bounds)
         // set language
//        if Localize.currentLanguage() == "en" {
//            self.Getallproducterepo.SendLanguage(Language: "en", completionSuccess: { (resulte) in
//
//            })
//        }
//        else {
//             self.Getallproducterepo.SendLanguage(Language: "ar", completionSuccess: { (resulte) in
//            })
//        }
        
        
        
        if Singeleton.logined {
            saveUserId(Userid:(Singeleton.userInfo?.id)!)
            saveUserAuthKey(Userauthkey:Singeleton.token)

            
            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let homeController : GetAllProducteAndFilter = storyboard.instantiateViewController(withIdentifier: "GetAllProducteAndFilter") as! GetAllProducteAndFilter
            
             let homeController : HomeVC = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
            
            let sideMenuViewController = SideMenuViewController()
            let appToolbarController = AppToolbarController(rootViewController: homeController)
            appToolbarController.toolbar.title = "Home"
            appToolbarController.mytitle="Home".localize()
            appToolbarController.toolbar.titleLabel.textColor=#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
             appToolbarController.toolbar.titleLabel.text =  "Home"
            if Localize.currentLanguage() == "en" {
                self.Getallproducterepo.SendLanguage(Language: "en", completionSuccess: { (resulte) in
                    
                })
                let viewController = AppNavigationDrawerController(rootViewController: appToolbarController, leftViewController: sideMenuViewController)
                viewController.isHiddenStatusBarEnabled = false
                nvc.navigationBar.topItem?.backButton.setTitle("Back".localized(), for: .normal)
                
                nvc = UINavigationController(rootViewController: viewController)
                 }
            else {
                self.Getallproducterepo.SendLanguage(Language: "ar", completionSuccess: { (resulte) in
                   
                    
                    
                })
                let viewController = AppNavigationDrawerController(rootViewController: appToolbarController, rightViewController: sideMenuViewController)
                viewController.isHiddenStatusBarEnabled = false
                nvc.navigationBar.topItem?.backButton.setTitle("Back".localized(), for: .normal)
                nvc = UINavigationController(rootViewController: viewController)
            }
        }
        else {

            nvc = UINavigationController(rootViewController: LoginVc())
        }

        self.window?.rootViewController = nvc
        self.window?.makeKeyAndVisible()

    }
    
    
//    func changeIntialViewController() {
//
//        setupLanguage()
//
//        self.window = UIWindow(frame: UIScreen.main.bounds)
//
//        isLogged = UserDefaults.standard.bool(forKey: defaultsKey.isLogged.rawValue)
//        UserDefaults.standard.synchronize()
//        print(isLogged!)
//
//        if token != nil && isLogged! {
//
//            var homeController = UIViewController()
//
//            switch userType {
//
//            case UserType.foodCars.rawValue?,UserType.partyCooks.rawValue?,UserType.houseCook.rawValue?:
//                homeController =  AppFABMenuController(rootViewController: CategoryCollectionViewController())
//
//            case UserType.deliveryPlace.rawValue?:
//                homeController = DeliveryPlaceHomeViewController()
//
//            case UserType.driverPartner.rawValue?:
//                homeController = DeliveryGuyVC()
//
//            default:
//                print("undefined type")
//            }
//
//            let sideMenuViewController = SideMenuViewController()
//            let appToolbarController = AppToolbarController(rootViewController: homeController)
//            appToolbarController.toolbar.title = "Home".localized()
//            if Localize.currentLanguage() == "ar" {
//                let viewController = AppNavigationDrawerController(rootViewController: appToolbarController, rightViewController: sideMenuViewController)
//                viewController.isHiddenStatusBarEnabled = false
//                nvc = UINavigationController(rootViewController: viewController)
//            }else {
//                let viewController = AppNavigationDrawerController(rootViewController: appToolbarController, leftViewController: sideMenuViewController)
//                viewController.isHiddenStatusBarEnabled = false
//                nvc.navigationBar.topItem?.backButton.setTitle("Back".localized(), for: .normal)
//                nvc = UINavigationController(rootViewController: viewController)
//            }
//        } else {
//            nvc = UINavigationController(rootViewController: LoginViewController())
//        }
//
//        self.window?.rootViewController = nvc
//        self.window?.makeKeyAndVisible()
//
//    }
//
    
    

}

