//
//  Somefunction.swift
//  FoodService
//
//  Created by index-ios on 4/12/18.
//  Copyright © 2018 index-ios. All rights reserved.
//

import UIKit
import Localize_Swift
func PresentHomeViewController(myViewController:UIViewController){
   var nvc = UINavigationController()
    
    
    myViewController.popoverPresentationController
    myViewController.dismiss(animated: true, completion: nil)
    
    
//    AppDelegate.instance.changeIntialViewController()
    myViewController.navigationController?.popToRootViewController(animated: true)
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
        
        
//        UIApplication.shared.keyWindow?.rootViewController?.view.makeToast("Order Has Send".localize())
        
        
        
//        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let homeController :HomeVC = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
//
//
//        let sideMenuViewController =  SideMenuViewController()
//        let appToolbarController = AppToolbarController(rootViewController: homeController)
//        appToolbarController.mytitle="Home".localize()
//        if Localize.currentLanguage() == "en" {
//            let viewController = AppNavigationDrawerController(rootViewController: appToolbarController, leftViewController: sideMenuViewController)
//            viewController.isHiddenStatusBarEnabled = false
//            nvc = UINavigationController(rootViewController: viewController)
//            UIApplication.shared.keyWindow?.rootViewController?.present(nvc, animated: true, completion: nil)
//
//
//        }
//        else {
//            let viewController = AppNavigationDrawerController(rootViewController: appToolbarController, rightViewController: sideMenuViewController)
//            viewController.isHiddenStatusBarEnabled = false
//            nvc = UINavigationController(rootViewController: viewController)
//            UIApplication.shared.keyWindow?.rootViewController?.present(nvc, animated: true, completion: nil)
//        }
        
        
        
        
        

    })
    
    
    
    
    
    
}
extension String {
   func  localize() -> String{
    return self.localized()
    }
}



extension UIApplication {
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}


extension UIView{
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
        
    }
    
    func removeBluerLoader(){
        self.subviews.flatMap {  $0 as? UIVisualEffectView }.forEach {
            $0.removeFromSuperview()
        }
    }
}


