//
//  UiimageView + extension.swift
//  FoodServiceClient
//
//  Created by Index PC-2 on 3/18/18.
//  Copyright © 2018 Index. All rights reserved.
//

import Foundation
import  UIKit
extension UIImageView {
    
    func convertToCircle() {
        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        //self.layer.borderColor = UIColor.blackColor().CGColor
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
}
extension UIImage {
    var circle: UIImage {
        let square = CGSize(width: 60, height: 60)
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: square))
        imageView.contentMode = .scaleAspectFill
        imageView.image = self
        imageView.layer.cornerRadius = square.width/2
        imageView.layer.masksToBounds = true
        UIGraphicsBeginImageContext(imageView.bounds.size)
        imageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result!
    }
    
}
