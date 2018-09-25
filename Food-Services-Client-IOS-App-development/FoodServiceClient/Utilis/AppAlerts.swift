//
//  AppAlerts.swift
//  FoodServiceProvider
//
//  Created by Index on 2/1/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import Foundation
import Moya
import Localize_Swift

class Alert {
    
    static func PhotosUploadReachToLimit() -> UIAlertController {
        let alert = UIAlertController(title: "".localized(), message: "Maximum number of photos is five".localized(), preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Cancel".localized(), style: UIAlertActionStyle.default, handler: nil))
        
        return alert
    }
    static func showAlert(message: String) -> UIAlertController {
        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Cancel".localized(), style: UIAlertActionStyle.default, handler: nil))
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)

        return alert
    }
    static func showAlert(title: String,message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Cancel".localized(), style: UIAlertActionStyle.default, handler: nil))
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
       
    }
    
    static func showError(_ response: Response) {
        
        do {
            if response.statusCode == StatusCode.forbidden.rawValue {
            UserDefaults.standard.set(true, forKey: defaultsKey.isLocked.rawValue)
                
            var user = Singeleton.userInfo
                user?.lock = true
                print(user)
               Singeleton.userDefaults.set((user?.toJSON())!, forKey: defaultsKey.userData.rawValue)
            let sideMenuViewController = SideMenuViewController()
            let appToolbarController = AppToolbarController(rootViewController: LockViewController())

            if Localize.currentLanguage() == "ar" {
                let viewController = AppNavigationDrawerController(rootViewController: appToolbarController, rightViewController: sideMenuViewController)
                viewController.isHiddenStatusBarEnabled = false
                UIApplication.shared.keyWindow?.rootViewController?.add(asChildViewController: viewController)
            } else {
                let viewController = AppNavigationDrawerController(rootViewController: appToolbarController, leftViewController: sideMenuViewController)
                viewController.isHiddenStatusBarEnabled = false
                UIApplication.shared.keyWindow?.rootViewController?.add(asChildViewController: viewController)
            }
                return
            }
        
            let errorResponse =  try response.mapObject(APIError.self)
            var error = errorResponse.error
            error = (error != nil ) ? error : errorResponse.generalError![0].msg
            Alert.showAlert(title: "Error".localized(), message: error!)
        } catch {}
    }
    
}

