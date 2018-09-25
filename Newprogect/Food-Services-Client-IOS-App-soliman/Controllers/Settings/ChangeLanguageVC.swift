//
//  ChangeLanguageVC.swift
//  FoodServiceProvider
//
//  Created by Index on 2/28/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import UIKit
import Localize_Swift
import Material

class ChangeLanguageVC: UIViewController {
    
    var didSetupConstraints = false
    var Getallproducterepo = GetallProdacteRepo()
    let iconLabel: UILabel = {
        let label = UILabel()
        label.textColor = .navigationBarColor()
        label.textAlignment = .center
        label.font = UIFont.fontAwesome(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
   
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.appFontRegular(ofSize: 16)
        label.numberOfLines = 1
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Language".localized()
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .lightGrayApp()
        return label
        
    }()
    
    let arabicLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.appFontBold(ofSize: 16)
        label.numberOfLines = 1
        label.textColor = .black
        label.setAlignment()
        label.isUserInteractionEnabled = true
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Arabic".localized()
        
        return label
        
    }()
    
    let englishLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.appFontBold(ofSize: 16)
        label.numberOfLines = 1
        label.textColor = .black
        label.setAlignment()
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "English".localized()
        return label
        
    }()
    
    var currentLanguage = UserDefaults.standard.string(forKey: defaultsKey.language.rawValue)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubView()
        setupView()
        setupNavigationBar()
        updateViewConstraints()
        
        setupLabels()
        
        let englishLabelTab = UITapGestureRecognizer(target: self, action: #selector(changeLanguageAction))
        let arabicLabelTab = UITapGestureRecognizer(target: self, action: #selector(changeLanguageAction))

        englishLabel.addGestureRecognizer(englishLabelTab)
        arabicLabel.addGestureRecognizer(arabicLabelTab)
        
        englishLabel.tag = 0
        arabicLabel.tag = 1
        // Do any additional setup after loading the view.
    }

    
    func addSubView() {
        view.addSubview(titleLabel)
        view.addSubview(arabicLabel)
        view.addSubview(englishLabel)
    }
    
    override func updateViewConstraints() {
        
        super.updateViewConstraints()
        if !didSetupConstraints {
            
            titleLabel.snp.makeConstraints {
                make in
                make.right.equalTo(self.view.snp.right)
                make.height.equalTo(50)
                make.left.equalTo(self.view.snp.left)
                make.top.equalTo(self.view.snp.top)
            }
            englishLabel.snp.makeConstraints {
                make in
                make.height.equalTo(50)
                make.top.equalTo(titleLabel.snp.bottom)
                make.right.equalTo(self.view.snp.right).offset(-20)
                make.left.equalTo(self.view.snp.left).offset(20)
            }
            arabicLabel.snp.makeConstraints {
                make in
                make.bottom.equalTo(self.view.snp.bottom)
                make.top.equalTo(englishLabel.snp.bottom)
                make.right.equalTo(self.view.snp.right).offset(-20)
                make.left.equalTo(self.view.snp.left).offset(20)
                make.height.equalTo(50)
            }
            didSetupConstraints = true
        }
    }
    
    func setupLabels() {
        
        currentLanguage = UserDefaults.standard.string(forKey: defaultsKey.language.rawValue)
        englishLabel.setAlignment()
        arabicLabel.setAlignment()
        if currentLanguage == "en" {
            iconLabel.removeFromSuperview()
            englishLabel.textColor = .navigationBarColor()
            arabicLabel.textColor = .black
            englishLabel.addIconLabel("fa-check", .navigationBarColor(), iconLabel)
            
            
        } else {
            
            
            
            iconLabel.removeFromSuperview()
            arabicLabel.addIconLabel("fa-check", .navigationBarColor(), iconLabel)
            englishLabel.textColor = .black
            arabicLabel.textColor = .navigationBarColor()
        }

    }
    
    @objc func changeLanguageAction(sender: UITapGestureRecognizer) {
        
        if sender.view?.tag == 0 {
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
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
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            Localize.setCurrentLanguage("en")
            
           
            UserDefaults.standard.set("en", forKey: defaultsKey.language.rawValue)
            let userdef = UserDefaults.standard
            userdef.set([Localize.currentLanguage()], forKey: "AppleLanguages")
            userdef.synchronize()
            Getallproducterepo.SendLanguage(Language: "en", completionSuccess: { (resulte) in
                
            })
        }
        else if sender.view?.tag == 1 {
            Localize.setCurrentLanguage("ar")
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
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
           
            UserDefaults.standard.set("ar", forKey: defaultsKey.language.rawValue)
            let userdef = UserDefaults.standard
            userdef.set([Localize.currentLanguage()], forKey: "AppleLanguages")
            userdef.synchronize()
            Getallproducterepo.SendLanguage(Language: "ar", completionSuccess: { (resulte) in
                
            })
        }
        setupLabels()
        AppDelegate.instance.changeIntialViewController()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
extension ChangeLanguageVC {
    
}
