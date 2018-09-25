//
//  UIColor.swift
//  FoodServiceProvider
//
//  Created by index-pc on 12/6/17.
//  Copyright © 2017 index-pc. All rights reserved.
//

import UIKit

extension UIColor {
    
     enum FoodService {
            static let blue = UIColor(hex: "126FAA")
            static let lighterBlue = UIColor(hex: "5CBDFB")
            static let green = UIColor(hex: "50E3C2")
            static let gray = UIColor(hex: "#8A8A8E")

    
        }
    convenience init(hex: String)
    {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
    
    class func navigationBarColor() -> UIColor {
        return UIColor.init(hex: "00bed8")
        
    }
    class func appColor() -> UIColor {
        return UIColor.init(hex: "4695a5")
    }
    
    class func appGreenColor() -> UIColor {
        return UIColor.init(hex: "03a621")
    }
    
    class func cardColor() -> UIColor {
        
        return #colorLiteral(red: 0.9145652056, green: 0.9703217149, blue: 0.982224524, alpha: 1)
    }
    class func finishedColor() -> UIColor {
        return #colorLiteral(red: 0.5626248121, green: 0.5526357889, blue: 0.5527088642, alpha: 1)
    }
    
    class func refusedColor() -> UIColor {
        return UIColor.init(hex: "ff003e")
    }
    
    class func deliveredColor() -> UIColor {
        return #colorLiteral(red: 0.2224165499, green: 0.4219763279, blue: 0.2317669988, alpha: 1)
    }
    
    class func pending() -> UIColor {
        return #colorLiteral(red: 0.8422671556, green: 0.8222643733, blue: 0.3190512061, alpha: 1)
    }
    class func arrived() -> UIColor {
        return #colorLiteral(red: 0.05998431891, green: 0.6318920851, blue: 0.1453197896, alpha: 1)
    }
    
    class func lightGrayApp() -> UIColor {
        return UIColor.init(hex: "d8d5d5")
    }
    class func acceptedColor() -> UIColor {
        return #colorLiteral(red: 0, green: 0.8666666667, blue: 0.1803921569, alpha: 1)
    }
    class func arrivedColor() -> UIColor {
        return #colorLiteral(red: 0.05098039216, green: 0.631372549, blue: 0.1450980392, alpha: 1)
    }
    
    class func onTheWayColor() -> UIColor {
        return #colorLiteral(red: 0.9137254902, green: 0.4980392157, blue: 0.2705882353, alpha: 1)
    }
    
    class func takenColor() -> UIColor {
        return #colorLiteral(red: 0.09803921569, green: 0.5647058824, blue: 0.9254901961, alpha: 1)
    }
}



