//
//  HeaderOfCompleteorderview.swift
//  FoodService
//
//  Created by index-ios on 3/14/18.
//  Copyright © 2018 index-ios. All rights reserved.
//

import UIKit


extension UIView {
    
    class func afromNib<T: UIView>() -> T {
        
        return Bundle.main.loadNibNamed("HeaderOfCompleteorder", owner: nil, options: nil)![0] as! T
    }
    
    class func Headerforsureorder<T: UIView>() -> T {
        return Bundle.main.loadNibNamed("HeaderforSureorder", owner: nil, options: nil)![0] as! T
    }
    
}
