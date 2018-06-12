//
//  Uihelpers.swift
//  FoodServiceClient
//
//  Created by Ramy Nasser Code95 on 3/8/18.
//  Copyright © 2018 Index. All rights reserved.
//

import Foundation
import UIKit
import Material
import SnapKit
import NVActivityIndicatorView
import Localize_Swift
import SystemConfiguration

class UiHelpers {

class func textField(placeholder: String) -> TextField {
    let field = ErrorTextField()
    field.placeholder = placeholder
    field.placeholderLabel.textAlignment = .natural
    field.placeholderActiveColor = field.placeholderNormalColor
    field.dividerActiveColor = field.dividerNormalColor
    if Localize.currentLanguage() == "en" {
        field.textAlignment = .left
    } else {
        field.textAlignment = .right
    }
    field.detailColor = UIColor.FoodService.gray
    return field
}



class func setEnabled<T:Button>(button: T, isEnabled: Bool) {
    if isEnabled {
        button.backgroundColor = UIColor.appColor()
        button.titleColor = UIColor.white
        button.isEnabled = true
    } else {
        button.isEnabled = false
        button.backgroundColor = Color.grey.lighten1
        button.titleColor = Color.white
    }
    
}

class func setEnabled<T:Button>(button: T, isEnabled: Bool, title: String) {
    if isEnabled {
        button.backgroundColor = UIColor.blue
        button.titleColor = UIColor.white
        button.isEnabled = true
    } else {
        button.isEnabled = false
        button.backgroundColor = Color.grey.lighten1
        button.titleColor = Color.white
    }
    
    button.title = title
    
}
    
    
    
}

