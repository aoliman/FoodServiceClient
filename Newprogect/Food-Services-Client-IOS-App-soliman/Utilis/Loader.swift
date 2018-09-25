//
//  Loader.swift
//  FoodServiceProvider
//
//  Created by Index on 12/21/17.
//  Copyright © 2017 index-pc. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import Localize_Swift

class Loader
{
    
    
    static var instance = Loader()
    static var alphView = UIView()
    static var loaderView = UIView()
    static var activityIndicatorView: NVActivityIndicatorView?
    static var animationTypeLabel = UILabel()
    static var backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
    
    static func showCustomLoader()
    {
        
        alphView = UIView(frame: (UIApplication.shared.keyWindow?.rootViewController?.view.frame)!)

        UIApplication.shared.keyWindow?.rootViewController?.view.addSubview(alphView)
        alphView.addSubview(loaderView)

        loaderView.snp.makeConstraints
            {
                make in
                make.width.equalTo(250)
                make.height.equalTo(80)
                make.center.equalTo(alphView.snp.center)
        }
//loaderView.bounds.minX + 20   loaderView.bounds.midY - 20
        activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 100 ,y: 100,width: 30, height:40), type: .ballSpinFadeLoader, color: UIColor.appColor())

        loaderView.addSubview(activityIndicatorView!)
        UIApplication.shared.keyWindow!.bringSubview(toFront: alphView)

        activityIndicatorView?.snp.makeConstraints
            {
                make in
                make.width.equalTo(50)
                make.height.equalTo(50)
                make.center.equalTo(loaderView.snp.center)
        }

        alphView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)

        activityIndicatorView?.startAnimating()
    }
    
    static func hideCustomLoader()
    {
        alphView.removeFromSuperview()

        activityIndicatorView?.stopAnimating()
    }
    
    
    
    
    
    class func showLoader() {
        let activityData = ActivityData(size: nil, message: nil, messageFont: nil, messageSpacing: nil, type: nil, color: UIColor.appColor(), padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: Loader.backgroundColor, textColor: nil)
        
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        
    }
    
    class func hideLoader() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
    
}
