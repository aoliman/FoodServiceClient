////
////  SettingCollectionViewCell.swift
////  FoodServiceProvider
////
////  Created by Index on 2/24/18.
////  Copyright © 2018 index-pc. All rights reserved.
////
//
//import UIKit
//import Localize_Swift
//import Material
//
//class SettingCollectionViewCell: UICollectionViewCell {
//
//    var didSetupConstraints = false
//
//    lazy var chatRepo = ChatRepo()
////    lazy var notificationRepo = NotificationRepo()
////
//    var onlineStatus = Bool()
//
//    var fcmToken: String?
//
//    var switchButton: UISwitch = {
//        let switchBtn = UISwitch()
//        switchBtn.onTintColor =  UIColor.navigationBarColor()
//        switchBtn.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
//        switchBtn.isHidden = true
//        switchBtn.translatesAutoresizingMaskIntoConstraints = false
//        return switchBtn
//    }()
//
//    var icon: UILabel = {
//
//        let label = UILabel()
//        label.textColor = .navigationBarColor()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.setAlignment()
//
//        label.font = UIFont.fontAwesome(ofSize: 20)
//
//        return label
//    }()
//
//    let label: UILabel = {
//
//        let label = UILabel()
//        label.font = UIFont.appFontRegular(ofSize: 16)
//        label.numberOfLines = 0
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.textColor = .black
//        label.setAlignment()
//        label.adjustsFontSizeToFitWidth = true
//        if #available(iOS 10.0, *) {
//         //   label.adjustsFontForContentSizeCategory = true
//        } else {
//            // Fallback on earlier versions
//        }
//        label.sizeToFit()
//        return label
//
//    }()
//
//    let value: ErrorTextField = {
//
//        let text = ErrorTextField()
//        text.setAlignment()
//        text.placeholderAnimation = .hidden
//        text.changeActiveColorPlaceholder()
//        text.font = UIFont.appFontRegular(ofSize: 16)
////        text.textColor = .lightGray
//        text.translatesAutoresizingMaskIntoConstraints  = false
//
//        return text
//
//    }()
//
//    let generalSetting: UITextField = {
//
//        let text = UITextField()
//        text.setAlignment()
////        text.placeholderAnimation = .hidden
////        text.changeActiveColorPlaceholder()
//        text.font = UIFont.appFontRegular(ofSize: 16)
//        text.textColor = .lightGray
//        text.translatesAutoresizingMaskIntoConstraints  = false
//
//        return text
//
//    }()
//    let button: UIButton = {
//        let button = UIButton()
//        button.titleLabel?.font = UIFont.fontAwesome(ofSize: 26)
//        button.titleLabel?.textAlignment = .center
//        button.setTitleColor(.navigationBarColor(), for: .selected)
//        button.isHidden = true
//        button.translatesAutoresizingMaskIntoConstraints = false
//
//        return button
//    }()
//
//    let visaIcon: UIImageView = {
//        let imageView = UIImageView()
//    //    imageView.masksToBounds = true
//        imageView.image = #imageLiteral(resourceName: "card_cash_checkout_credit_visa_icon_256")
//        imageView.clipsToBounds = true
//        imageView.isHidden = true
//        imageView.contentMode = .scaleAspectFit
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
//    let cashIcon: UIImageView = {
//        let imageView = UIImageView()
//      //  imageView.masksToBounds = true
//        imageView.isHidden = true
//        imageView.clipsToBounds = true
//        imageView.image = #imageLiteral(resourceName: "American-Express-icon")
//        imageView.contentMode = .scaleAspectFit
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
//    let payPalIcon: UIImageView = {
//        let imageView = UIImageView()
//    //    imageView.masksToBounds = true
//        imageView.clipsToBounds = true
//        imageView.isHidden = true
//        imageView.image = #imageLiteral(resourceName: "mastercard3")
//        imageView.contentMode = .scaleAspectFit
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        addViews()
//        updateViewConstraints()
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        label.sizeToFit()
//    }
//
//    func setupNotificationButton(_ cell: SettingCollectionViewCell?) {
//
//        fcmToken = UserDefaults.standard.string(forKey: defaultsKey.fcmToken.rawValue)
//
//        if fcmToken !=  nil {
//            cell?.switchButton.setOn(true, animated: true)
//           // self.notificationRepo.unSubscribeNotification()
//
//        }
//        else {
//            cell?.switchButton.setOn(false, animated: true)
//          //  self.notificationRepo.subscribeNotification()
//
//        }
//
//    }
//
//    func setupOnlineButton(_ cell: SettingCollectionViewCell?) {
//        onlineStatus = UserDefaults.standard.bool(forKey: defaultsKey.onlineStatus.rawValue)
//        cell?.switchButton.setOn(onlineStatus, animated: true)
//        cell?.switchButton.addTarget(self, action: #selector(setOnlineAction), for: .valueChanged)
//    }
//
//    func updateViewConstraints() {
//
//        icon.snp.makeConstraints {
//            make in
//            make.top.equalTo(self.snp.top).offset(15)
//            make.width.equalTo(30)
//            make.height.equalTo(30)
//            if Localize.currentLanguage() == "ar" {
//                make.right.equalTo(self.snp.right).offset(-10)
//            } else {
//                make.left.equalTo(self.snp.left).offset(10)
//            }
//        }
//
//        label.snp.makeConstraints {
//
//            make in
//            make.top.equalTo(self.snp.top).offset(15)
//
//            if UIDevice.current.model == "iPad" {
//                make.height.equalTo(40)
//            } else {
//                make.height.equalTo(30)
//            }
//
//            if Localize.currentLanguage() == "ar" {
//                make.right.equalTo(icon.snp.left).offset(-10)
//            } else {
//                make.left.equalTo(icon.snp.right).offset(10)
//            }
//
//           // make.width.equalTo(self.snp.width).multipliedBy(0.2)
//        }
//
//        value.snp.makeConstraints {
//
//            make in
//            make.top.equalTo(self.snp.top).offset(15)
//            if UIDevice.current.model == "iPad" {
//                make.height.equalTo(40)
//            } else {
//                make.height.equalTo(30)
//            }
//            if Localize.currentLanguage() == "ar" {
//                make.right.equalTo(label.snp.left).offset(-10)
//                make.left.equalTo(self.snp.left).offset(35)
//
//            } else {
//                make.left.equalTo(label.snp.right).offset(10)
//                make.right.equalTo(self.snp.right).offset(-35)
//
//            }
//        }
//        generalSetting.snp.makeConstraints {
//
//            make in
//            make.top.equalTo(self.snp.top).offset(15)
//            if UIDevice.current.model == "iPad" {
//                make.height.equalTo(40)
//            } else {
//                make.height.equalTo(30)
//            }
//            if Localize.currentLanguage() == "ar" {
//                make.right.equalTo(label.snp.left).offset(-10)
//                make.left.equalTo(self.snp.left).offset(35)
//
//            } else {
//                make.left.equalTo(label.snp.right).offset(10)
//                make.right.equalTo(self.snp.right).offset(-35)
//
//            }
//        }
//        switchButton.snp.makeConstraints {
//            make in
//            if UIDevice.current.model == "iPad" {
//                make.width.equalTo(90)
//                make.height.equalTo(60)
//            } else {
//                make.width.equalTo(50)
//                make.height.equalTo(40)
//            }
//
//            make.top.equalTo(self.snp.top).offset(15)
//            if Localize.currentLanguage() == "ar" {
//                make.left.equalTo(self.snp.left).offset(5)
//
//            } else {
//                make.right.equalTo(self.snp.right).offset(-5)
//
//            }
//        }
//
//        visaIcon.snp.makeConstraints {
//            make in
//            if Localize.currentLanguage() == "ar" {
//                make.right.equalTo(label.snp.right)
//            } else {
//                make.left.equalTo(label.snp.left)
//            }
//            if UIDevice.current.model == "iPad" {
//                make.width.height.equalTo(value.snp.width).multipliedBy(0.1)
//
//            } else {
//                make.width.height.equalTo(value.snp.width).multipliedBy(0.2)
//
//            }
//            make.top.equalTo(label.snp.bottom).offset(10)
//        }
//
//        payPalIcon.snp.makeConstraints {
//            make in
//            if Localize.currentLanguage() == "ar" {
//                make.right.equalTo(visaIcon.snp.left).offset(-10)
//            } else {
//                make.left.equalTo(visaIcon.snp.right).offset(10)
//            }
//            make.width.height.equalTo(visaIcon.snp.width)
//            make.top.equalTo(visaIcon.snp.top)
//        }
//
//        cashIcon.snp.makeConstraints {
//            make in
//            if Localize.currentLanguage() == "ar" {
//                make.right.equalTo(payPalIcon.snp.left).offset(-10)
//
//            } else {
//                make.left.equalTo(payPalIcon.snp.right).offset(10)
//
//            }
//            make.width.height.equalTo(visaIcon.snp.width)
//            make.top.equalTo(visaIcon.snp.top)
//        }
//
//
//        label.sizeToFit()
//        value.sizeToFit()
//
//    }
//
//    func addViews() {
//
//        addSubview(icon)
//        addSubview(label)
//        addSubview(value)
//        addSubview(generalSetting)
//        addSubview(button)
//        addSubview(switchButton)
//        addSubview(visaIcon)
//        addSubview(payPalIcon)
//        addSubview(cashIcon)
//    }
//
//    @objc func setOnlineAction() {
//        chatRepo.getOnlineStatus(online: switchButton.isOn) { (statusCode) in
//            switch statusCode {
//
//            case StatusCode.complete.rawValue , StatusCode.success.rawValue, StatusCode.undocumented.rawValue:
//                UserDefaults.standard.set(self.switchButton.isOn, forKey: defaultsKey.onlineStatus.rawValue)
//                self.switchButton.setOn(self.switchButton.isOn, animated: true)
//
//            case StatusCode.badRequest.rawValue:
//                DataUtlis.data.ErrorDialog(Title: "Error".localized(), Body: "badRequest")
//
//            case StatusCode.unauthorized.rawValue:
//                DataUtlis.data.ErrorDialog(Title: "Error".localized(), Body: "unauthenticated")
//
//            case StatusCode.forbidden.rawValue:
//                DataUtlis.data.ErrorDialog(Title: "Error".localized(), Body: "forbidden")
//
//            case StatusCode.notFound.rawValue:
//                DataUtlis.data.ErrorDialog(Title: "Error".localized(), Body: "not Found")
//
//
//            case StatusCode.unprocessableEntity.rawValue:
//                DataUtlis.data.ErrorDialog(Title: "Error".localized(), Body: "not Found")
//
//            case StatusCode.serverError.rawValue :
//                DataUtlis.data.ErrorDialog(Title: "Error".localized(), Body: "ServrError".localized())
//
//            default:
//                DataUtlis.data.noInternetDialog()
//
//            }
//        }
//
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}



//
//  SettingCollectionViewCell.swift
//  FoodServiceProvider
//
//  Created by Index on 2/24/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import UIKit
import Localize_Swift
import Material

class SettingCollectionViewCell: UICollectionViewCell {
    
    var didSetupConstraints = false
    
    lazy var chatRepo = ChatRepo()
    lazy var notificationRepo = NotificationRepo()
    
    var onlineStatus = Bool()
    
    var fcmToken: String?
    
    var switchButton: UISwitch = {
        let switchBtn = UISwitch()
        switchBtn.onTintColor =  UIColor.navigationBarColor()
        switchBtn.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        switchBtn.isHidden = true
        switchBtn.translatesAutoresizingMaskIntoConstraints = false
        return switchBtn
    }()
    
    var icon: UILabel = {
        
        let label = UILabel()
        label.textColor = .navigationBarColor()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setAlignment()
        label.font = UIFont.fontAwesome(ofSize: 20)
        
        return label
    }()
    
    let label: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.appFontRegular(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.setAlignment()
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        return label
        
    }()
    
    let generalSetting: UILabel = {
        
        let label = UILabel()
        label.setAlignment()
        label.font = UIFont.appFontRegular(ofSize: 16)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints  = false
        
        return label
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.fontAwesome(ofSize: 26)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.navigationBarColor(), for: .selected)
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let visaIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.image = #imageLiteral(resourceName: "visa")
        imageView.clipsToBounds = true
        imageView.isHidden = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let masterCardIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.isHidden = true
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "mastercard")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let americanCardIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.isHidden = true
        imageView.image = #imageLiteral(resourceName: "American-Express-icon")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        updateViewConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.sizeToFit()
        generalSetting.sizeToFit()
        icon.sizeToFit()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        icon.translatesAutoresizingMaskIntoConstraints = false
        americanCardIcon.isHidden = true
        masterCardIcon.isHidden = true
        visaIcon.isHidden = true
        switchButton.isHidden = true
        generalSetting.text = nil
        
    }
    func setupNotificationButton(_ cell: SettingCollectionViewCell?) {
        
        fcmToken = UserDefaults.standard.string(forKey: defaultsKey.fcmToken.rawValue)
        
        if fcmToken !=  nil {
            cell?.switchButton.setOn(true, animated: true)
          //  self.notificationRepo.unSubscribeNotification()
        }
        else {
            cell?.switchButton.setOn(false, animated: true)
         //   self.notificationRepo.subscribeNotification()
        }
        
    }
    
    func setupOnlineButton(_ cell: SettingCollectionViewCell?) {
        onlineStatus = UserDefaults.standard.bool(forKey: defaultsKey.onlineStatus.rawValue)
        cell?.switchButton.setOn(onlineStatus, animated: true)
        cell?.switchButton.addTarget(self, action: #selector(setOnlineAction), for: .valueChanged)
    }
    
    func updateViewConstraints() {
        
        icon.snp.remakeConstraints {
            make in
            make.top.equalTo(self.snp.top).offset(15)
            //            make.width.equalTo(30)
            //            make.height.equalTo(30)
            if Localize.currentLanguage() == "ar" {
                make.right.equalTo(self.snp.right).offset(-10)
            } else {
                make.left.equalTo(self.snp.left).offset(10)
            }
        }
        
        label.snp.remakeConstraints {
            
            make in
            make.top.equalTo(self.snp.top).offset(15)
            
            if UIDevice.current.model == "iPad" {
                make.height.equalTo(40)
            } else {
                make.height.equalTo(30)
            }
            if Localize.currentLanguage() == "ar" {
                make.right.equalTo(icon.snp.left).offset(-10)
            } else {
                make.left.equalTo(icon.snp.right).offset(10)
            }
        }
        
        generalSetting.snp.remakeConstraints {
            make in
            make.top.equalTo(self.snp.top).offset(15)
            if UIDevice.current.model == "iPad" {
                make.height.equalTo(40)
            } else {
                make.height.equalTo(30)
            }
            
            if Localize.currentLanguage() == "ar" {
                make.left.equalTo(self.snp.left).offset(10)
                
            } else {
                make.right.equalTo(self.snp.right).offset(-10)
                
            }
        }
        switchButton.snp.remakeConstraints {
            make in
            if UIDevice.current.model == "iPad" {
                make.width.equalTo(90)
                make.height.equalTo(60)
            } else {
                make.width.equalTo(50)
                make.height.equalTo(40)
            }
            
            make.top.equalTo(self.snp.top).offset(15)
            if Localize.currentLanguage() == "ar" {
                make.left.equalTo(self.snp.left).offset(5)
                
            } else {
                make.right.equalTo(self.snp.right).offset(-5)
                
            }
        }
        
        visaIcon.snp.remakeConstraints {
            make in
            if Localize.currentLanguage() == "ar" {
                make.right.equalTo(label.snp.right)
            } else {
                make.left.equalTo(label.snp.left)
            }
            make.width.height.equalTo(self.snp.height).multipliedBy(0.7)
            make.top.equalTo(label.snp.bottom).offset(10)
        }
        
        americanCardIcon.snp.remakeConstraints {
            make in
            if Localize.currentLanguage() == "ar" {
                make.right.equalTo(visaIcon.snp.left).offset(-10)
            } else {
                make.left.equalTo(visaIcon.snp.right).offset(10)
            }
            make.width.height.equalTo(visaIcon.snp.width)
            make.top.equalTo(visaIcon.snp.top)
        }
        
        masterCardIcon.snp.remakeConstraints {
            make in
            if Localize.currentLanguage() == "ar" {
                make.right.equalTo(americanCardIcon.snp.left).offset(-10)
                
            } else {
                make.left.equalTo(americanCardIcon.snp.right).offset(10)
                
            }
            make.width.height.equalTo(visaIcon.snp.width)
            make.top.equalTo(visaIcon.snp.top)
        }
        
        
        label.sizeToFit()
        
    }
    
    func addViews() {
        
        addSubview(icon)
        addSubview(label)
        addSubview(generalSetting)
        addSubview(button)
        addSubview(switchButton)
        addSubview(visaIcon)
        addSubview(americanCardIcon)
        addSubview(masterCardIcon)
    }
    
    @objc func setOnlineAction() {
        
        chatRepo.getOnlineStatus(online: switchButton.isOn) {
            
            (statusCode) in
            switch statusCode {
            case StatusCode.complete.rawValue , StatusCode.success.rawValue, StatusCode.undocumented.rawValue:
                UserDefaults.standard.set(self.switchButton.isOn, forKey: defaultsKey.onlineStatus.rawValue)
                self.switchButton.setOn(self.switchButton.isOn, animated: true)
                
            case StatusCode.badRequest.rawValue:
                DataUtlis.data.ErrorDialog(Title: "Error".localized(), Body: "badRequest")
                
            case StatusCode.unauthorized.rawValue:
                DataUtlis.data.ErrorDialog(Title: "Error".localized(), Body: "unauthenticated")
                
            case StatusCode.forbidden.rawValue:
                DataUtlis.data.ErrorDialog(Title: "Error".localized(), Body: "forbidden")
                
            case StatusCode.notFound.rawValue:
                DataUtlis.data.ErrorDialog(Title: "Error".localized(), Body: "not Found")
                
            case StatusCode.unprocessableEntity.rawValue:
                DataUtlis.data.ErrorDialog(Title: "Error".localized(), Body: "not Found")
                
            case StatusCode.serverError.rawValue :
                DataUtlis.data.ErrorDialog(Title: "Error".localized(), Body: "ServrError".localized())
                
            default:
                DataUtlis.data.noInternetDialog()
                
            }
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
