//
//  textfield.swift
//  FoodServiceProvider
//
//  Created by index-pc on 12/11/17.
//  Copyright © 2017 index-pc. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Localize_Swift
import DropDown
import Material

extension UITextField {
    
    func addIconLabel(_ icon: String, _ color: UIColor, _ iconLabel: UILabel)
    {
        self.addSubview(iconLabel)
        iconLabel.textColor = color
        iconLabel.text = String.fontAwesomeIcon(code: icon)
        
        iconLabel.snp.remakeConstraints { make in
            if Localize.currentLanguage() == "en"
            {
                make.right.equalTo(self.snp.right).offset(-10)

            }
            else
            {
                make.left.equalTo(self.snp.left).offset(10)

            }
            make.width.equalTo(30)
            make.height.equalTo(self.snp.height)
            make.centerY.equalTo(self)
        }
        iconLabel.isHidden = false
    }
    
    func addIconButton(_ icon: String, _ color: UIColor, _ iconButton: UIButton)
    {
        iconButton.setTitleColor(.lightGray, for: .normal)
        iconButton.setTitleColor(.navigationBarColor(), for: .selected)
        iconButton.setTitle(String.fontAwesomeIcon(code: icon), for: .normal)
        
        iconButton.snp.remakeConstraints {
            make in
            if Localize.currentLanguage() == "en"
            {
                make.left.equalTo(self.snp.right).offset(-10)

            }
            else
            {
                make.right.equalTo(self.snp.left).offset(10)

            }
            make.width.equalTo(30)
            make.height.equalTo(self.snp.height)
            make.centerY.equalTo(self)
        }
        
    }
    
    
    func addValidationIcon(validationErrorLabel: UILabel )
    {
        validationErrorLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(validationErrorLabel)
        validationErrorLabel.snp.remakeConstraints
            {
                make in
                if Localize.currentLanguage() == "en"
                {
                    make.right.equalTo(self.snp.right).offset(-10)

                }
                else
                {
                    make.left.equalTo(self.snp.left).offset(10)

                }
                make.width.equalTo(30)
                make.height.equalTo(self.snp.height)
                make.centerY.equalTo(self)
        }
        validationErrorLabel.isHidden = false
    }
    
    func setAlignment()
    {
        if Localize.currentLanguage() == "en"
        {
            self.textAlignment = .left

        }
        else
        {
            self.textAlignment = .right

        }
    }
    
}
extension TextField
{
    func changeActiveColorPlaceholder()
    {
        self.dividerActiveColor = UIColor.navigationBarColor()
        self.placeholderActiveColor = UIColor.navigationBarColor()
    }
    
    func addDownArrow()
    {
        self.placeholderVerticalOffset = 0
        self.removeDictationResultPlaceholder(self, willInsertResult: false)
        let icon: UILabel = {
            
            let label = UILabel()
            label.font = UIFont.fontAwesome(ofSize: 16)
            label.textColor = .lightGray
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = String.fontAwesomeIcon(code: "fa-angle-down")
            label.textAlignment = .center
            
            return label
        }()
        
        self.addSubview(icon)
        
        if(Localize.currentLanguage() == "en")
        {
            icon.snp.makeConstraints
                {
                    make in
                    make.right.equalTo(self.snp.right).offset(-10)
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
                    make.left.equalTo(self.snp.left).offset(10)
                    make.width.equalTo(30)
                    make.height.equalTo(30)
                    make.centerY.equalTo(self.snp.centerY)
            }
            
           
        }
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.adjustsFontSizeToFitWidth = true
//                if UIDevice.modelName.contains("Simulator ") {
//                   let model = UIDevice.modelName.replacingOccurrences(of: "Simulator ", with: "")
//                    if model == "iPhone SE" {
//                        self.font = UIFont.appFontRegular(ofSize: 10)
//                    }
//                }
        
    }
    
}



