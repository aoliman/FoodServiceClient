//
//  UIButton.swift
//  FoodServiceProvider
//
//  Created by Index on 12/18/17.
//  Copyright © 2017 index-pc. All rights reserved.
//

import Localize_Swift
import Material

extension UIButton
{
    func setAlignment()
    {
        if Localize.currentLanguage() == "en"
        {
            self.titleLabel?.textAlignment = .left

        }
        else
        {
            self.titleLabel?.textAlignment = .right

        }
    }
    
    class func appButton() -> UIButton
    {
        let button: UIButton = {
            let button = Button(type: .custom)
            button.titleLabel?.font = UIFont.appFontRegular(ofSize: 16)
            button.backgroundColor = UIColor.appColor()
            button.titleLabel?.textAlignment = .left
            button.layer.cornerRadius = 4
            button.setTitleColor(.white, for: .normal)
            button.translatesAutoresizingMaskIntoConstraints  = false
            button.pulseColor = .white
            
            return button
        }()
        
        return button
    }
    
    class func FlatButton() -> FlatButton
    {
        let button: FlatButton = {
            let button = FlatButton()
            button.titleLabel?.font = UIFont.appFontRegular(ofSize: 16)
            button.backgroundColor = UIColor.appColor()
            button.titleLabel?.textAlignment = .left
            button.layer.cornerRadius = 10
            button.setTitleColor(.white, for: .normal)
            button.translatesAutoresizingMaskIntoConstraints  = false
            button.pulseColor = .white
            
            return button
        }()
        
        return button
    }
    
    func addDownArrow()
    {
        let icon: UILabel = {
            
            let label = UILabel()
            label.font = UIFont.fontAwesome(ofSize: 16)
            label.textColor = UIColor.navigationBarColor()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = String.fontAwesomeIcon(code: "fa-angle-down")
            
            return label
        }()
        
        self.addSubview(icon)
        
        if(Localize.currentLanguage() == "en")
        {
            icon.snp.makeConstraints
                {
                    make in
                    make.right.equalTo(self.snp.right).offset(-5)
                    make.width.equalTo(30)
                    make.height.equalTo(30)
                    make.centerY.equalTo(self.snp.centerY)
            }
            
            
        }
        else
        {
            icon.snp.makeConstraints
                {
                    make in
                    make.left.equalTo(self.snp.left).offset(5)
                    make.width.equalTo(30)
                    make.height.equalTo(30)
                    make.centerY.equalTo(self.snp.centerY)
            }
        }
    }
    
//    open override func layoutSubviews() {
//        super.layoutSubviews()
//
//        self.titleLabel?.adjustsFontSizeToFitWidth  = true
//
//
//    }
}

