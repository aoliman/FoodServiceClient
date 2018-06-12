//
//  UIFont+ExampleFonts.swift
//  Segmentio
//
//  Created by Dmitriy Demchenko
//  Copyright © 2016 Yalantis Mobile. All rights reserved.
//

import UIKit

extension UIFont {
    
    class func exampleAvenirMedium(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Cocon® Next Arabic-Light", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    class func exampleAvenirLight(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Cocon® Next Arabic-Light", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    //please fill the font
    class func appFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "CoconNextArabic-Light", size: size)!
    }
    
    //please fill the font
    class func appFontLight(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "CoconNextArabic-Light", size: size)!
    } //please fill the font
    class func appFontBold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "CoconNextArabic-Bold", size: size)!
    } //please fill the font
    class func appFontRegular(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "CoconNextArabic-Regular", size: size)!
    }
    
}

class AppFont {
    static func printFonts() {
        
    }
    
}

