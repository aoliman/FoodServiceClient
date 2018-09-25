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
import Firebase
class AppToolbarController: ToolbarController {
    var mytitle : String?
    fileprivate var menuButton: IconButton!
    fileprivate var emailButton: IconButton!
    fileprivate var bellButton: IconButton!
    let emailIcon: UIButton = {
        
        let button = UIButton()
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.fontAwesome(ofSize: 20)
        button.setTitle(String.fontAwesomeIcon(code: "fa-circle"), for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.isHidden = true
        
        return button
    }()
    
    var emailsCount: Int = 0
    
    let emailLabel: UILabel = {
        
        let label = UILabel()
        label.sizeToFit()
        label.textColor = .white
        label.font = UIFont.appFontBold(ofSize: 10)
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    let userId = (Singeleton.userInfo?.id)!
    open override func prepare() {
        super.prepare()
        self.view.backgroundColor = .white
        
        layoutSubviews()
        getUnSeenCount()
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
    
    func getUnSeenCount() {
        
        userRef.child("\(userId)").child("unSeen")
            .observe(.value, with: {
                
                [weak self] (snapshot) in
                self?.emailsCount = 0
                if  snapshot.exists() {
                    
                    for childSnap in  snapshot.children.allObjects.reversed() {
                        
                        let snap = childSnap as! DataSnapshot
                        self?.emailsCount += snap.value as! Int
                    }
                    
                    if self?.emailsCount != 0 {
                        self?.emailIcon.isHidden = false
                        self?.emailLabel.text = String(describing: (self?.emailsCount)!)
                    } else {
                        self?.emailIcon.isHidden = true
                    }
                    
                } else {
                    self?.emailIcon.isHidden = true
                    print("error")
                }
                
            })
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
        emailIcon.isUserInteractionEnabled = false
        self.emailButton.addSubview(emailIcon)
        emailIcon.addSubview(emailLabel)
        
        if Localize.currentLanguage() == "ar" {
            
            emailIcon.snp.makeConstraints() {
                make in
                make.right.equalTo(self.emailButton.snp.right).offset(-2)
                make.height.equalTo(25)
                make.top.equalTo(self.emailButton.snp.top)
            }
            emailLabel.snp.makeConstraints() {
                make in
                make.center.equalTo(emailIcon.snp.center)
                make.height.equalTo(emailIcon.snp.height)
            }
            
        } else {
            
            emailIcon.snp.makeConstraints() {
                make in
                make.left.equalTo(self.emailButton.snp.left).offset(2)
                make.height.equalTo(25)
                make.top.equalTo(self.emailButton.snp.top)
            }
            emailLabel.snp.makeConstraints() {
                make in
                make.center.equalTo(emailIcon.snp.center)
                make.height.equalTo(emailIcon.snp.height)
            }
        }
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
        toolbar.titleLabel.adjustsFontSizeToFitWidth = true
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
        if Singeleton.userInfo?.lock == true && ((Singeleton.userInfo) != nil){
             transition(to: LockViewController())
        }else{
            toolbar.title = "Notification".localized()
            transition(to: NotificationViewController())
        }
        
    }
    
    @objc
    func handleEmail(button: UIButton) {
        if Singeleton.userInfo?.lock == true && ((Singeleton.userInfo) != nil){
            transition(to: LockViewController())
        }else{
        toolbar.title = "Chat".localized()
       transition(to: ChatListViewController())
        }
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
