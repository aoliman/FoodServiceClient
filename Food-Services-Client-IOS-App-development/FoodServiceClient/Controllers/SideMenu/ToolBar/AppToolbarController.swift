//
//  AppToolbarController.swift
//  FoodServiceProvider
//
//  Created by Index on 1/2/18.
//  Copyright © 2018 index-pc. All rights reserved.
//


import UIKit
import Material
import Localize_Swift

class AppToolbarController: ToolbarController {
    var mytitle : String?
    fileprivate var menuButton: IconButton!
    fileprivate var emailButton: IconButton!
    fileprivate var bellButton: IconButton!
   
    open override func prepare() {
        super.prepare()
        self.view.backgroundColor = .white
      
        layoutSubviews()
        prepareMenuButton()
        prepareEmailButton()
        prepareBellButton()
        prepareStatusBar()
        prepareToolbar()
    }
    
    open override func layoutSubviews() {
        
        super.layoutSubviews()
        
        var y = CGFloat()
        
        if #available(iOS 11.0, *) {
             y = view.safeAreaInsets.top
            
        } else {
             y = statusBar.bounds.maxY

        }

//        toolbar.frame.midY = y
//        toolbar.width = view.width
//
//        switch toolbarDisplay {
//        case .partial:
//            let h = y + toolbar.height
//
//            rootViewController.view.y = h
//            rootViewController.view.height = view.height - h
//        case .full:
//            rootViewController.view.frame = view.bounds
//        }
    }
}

fileprivate extension AppToolbarController {
    
    func prepareMenuButton() {
        menuButton = IconButton(image: Icon.menu, tintColor: .white)
        menuButton.pulseColor = .white
        menuButton.addTarget(self, action: #selector(handleMenuButton), for: .touchUpInside)

    }
    
    func prepareEmailButton() {
        
        emailButton = IconButton(image: Icon.email, tintColor: .white)
        emailButton.pulseColor = .white
        emailButton.addTarget(self, action: #selector(handleEmail(button:)), for: .touchUpInside)
    }
    
    func prepareBellButton() {
     
        bellButton = IconButton(image: Icon.bell, tintColor: .white)
        bellButton.pulseColor = .white
        bellButton.addTarget(self, action: #selector(handleBell(button:)), for: .touchUpInside)
    }
    
    func prepareStatusBar() {
        statusBarStyle = .lightContent
    }
    
    func prepareToolbar() {

        toolbar.backgroundColor = UIColor.navigationBarColor()
        toolbar.titleLabel.textColor = .white
        toolbar.titleLabel.font = UIFont.appFontRegular(ofSize: 16)
        if let toolbartitle = mytitle {
            toolbar.title = toolbartitle
        }
        
        
        if Localize.currentLanguage() == "en" {
            toolbar.leftViews = [menuButton]
            toolbar.rightViews = [emailButton, bellButton]
           
        } else {
            toolbar.leftViews = [bellButton, emailButton]
            toolbar.rightViews = [menuButton]
        }
    }
}

fileprivate extension AppToolbarController {
    @objc
    func handleBell(button: UIButton) {
       //go to notification
        self.title = "Notification".localized()
        transition(to: NotificationViewController())
    }
    
    @objc
    func handleEmail(button: UIButton) {
        self.title = "Chat".localized()
       transition(to: ChatListViewController())
    }
    
    @objc
    func handleMenuButton(button: UIButton) {
        if Localize.currentLanguage() == "en" {
            navigationDrawerController?.toggleLeftView()

        } else {
            navigationDrawerController?.toggleRightView()

        }
    }
}
