//
//  Load.swift
//  FoodServiceClient
//
//  Created by index-ios on 5/10/18.
//  Copyright © 2018 Index. All rights reserved.
//

import UIKit
class myLoader
{


    static var instance = myLoader()
    static var activityindecator:UIActivityIndicatorView = UIActivityIndicatorView()
    static func showCustomLoader( )
    {
//        activityindecator.center = (UIApplication.shared.keyWindow?.rootViewController?.view.center)!
//      activityindecator.hidesWhenStopped = true
//      activityindecator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
////        activityindecator.frame(forAlignmentRect: CGRect(x: 0, y: 0, width: (UIApplication.shared.keyWindow?.currentViewController()?.view.frame.bounds.width)!, height: (UIApplication.shared.keyWindow?.currentViewController()?.view.frame.bounds.height)!))
//        activityindecator.bounds =  CGRect(x: 0, y: 0, width: (UIApplication.shared.keyWindow?.currentViewController()?.view.frame.bounds.width)!, height: (UIApplication.shared.keyWindow?.currentViewController()?.view.frame.bounds.height)!)
//        activityindecator.color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        activityindecator.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4014078776)
//        activityindecator.sizeThatFits(CGSize(width: 100, height: 100))
//     UIApplication.shared.keyWindow?.currentViewController()?.view.addSubview(activityindecator)
//
//     activityindecator.startAnimating()
//
//    // UIApplication.shared.beginIgnoringInteractionEvents()
//

    }

    static func hideCustomLoader()
    {
         activityindecator.stopAnimating()
        activityindecator.stopAnimating()
        activityindecator.stopAnimating()
        activityindecator.stopAnimating()
        activityindecator.stopAnimating()
       
    }

    static func showCustomLoaderview(uiview :UIView )
    {
       
        activityindecator.center = (uiview.center)
        activityindecator.hidesWhenStopped = true
        activityindecator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.init(rawValue: 10)!
        activityindecator.alpha = 0.5
        //        activityindecator.frame(forAlignmentRect: CGRect(x: 0, y: 0, width: (UIApplication.shared.keyWindow?.currentViewController()?.view.frame.bounds.width)!, height: (UIApplication.shared.keyWindow?.currentViewController()?.view.frame.bounds.height)!))
        activityindecator.frame =  CGRect(x: 0, y: 0, width: (uiview.frame.width), height: (uiview.frame.height))
        activityindecator.color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        activityindecator.backgroundColor = #colorLiteral(red: 0.89109236, green: 0.8857948184, blue: 0.8951648474, alpha: 0.5)
        activityindecator.sizeThatFits(CGSize(width: 200, height: 200))
        let homevc = HomeVC()
        if(uiview.tag == 500){
            
            uiview.insertSubview(activityindecator, at: 1)
        }else{
         uiview.addSubview(activityindecator)
        }
        

        activityindecator.startAnimating()

       


    }



    

}


