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
    
    
    func getUserImageType( type: String, status: String) {
        
        
        if status == DeliveryGuyOrderStatus.accepted.rawValue {
            self.backgroundColor = UIColor.acceptedColor()
        } else if status == DeliveryGuyOrderStatus.delivered.rawValue {
            self.backgroundColor = UIColor.deliveredColor()
        } else if status == DeliveryGuyOrderStatus.finished.rawValue {
            self.backgroundColor = UIColor.finishedColor()
        } else if status == DeliveryGuyOrderStatus.refused.rawValue {
            self.backgroundColor = UIColor.refusedColor()
        } else if status == DeliveryGuyOrderStatus.pending.rawValue {
            self.backgroundColor = UIColor.pending()
        } else if status == DeliveryGuyOrderStatus.onTheWay.rawValue {
            self.backgroundColor = UIColor.onTheWayColor()
        } else if status == DeliveryGuyOrderStatus.taken.rawValue {
            self.backgroundColor = UIColor.takenColor()
        } else if status == DeliveryGuyOrderStatus.arrived.rawValue {
            self.backgroundColor = UIColor.arrivedColor()
        } else {
            self.backgroundColor = #colorLiteral(red: 0.9214878678, green: 0.9216204286, blue: 0.9214589, alpha: 1)
        }
        
        if ( type == UserType.deliveryPlace.rawValue ) {
            self.image = #imageLiteral(resourceName: "DELIVERY_PLACE")
        } else if type == UserType.houseCook.rawValue {
            self.image = #imageLiteral(resourceName: "home_cooker-1")
        } else if type == UserType.partyCooks.rawValue {
            self.image = #imageLiteral(resourceName: "party_cooker-1")
        } else if type == UserType.driverPartner.rawValue {
            self.image = #imageLiteral(resourceName: "delivery_white_partner")
        } else if type == UserType.foodCars.rawValue {
            self.image = #imageLiteral(resourceName: "food_car_white")
        } else if type == UserType.restaurantOwner.rawValue {
            self.image = #imageLiteral(resourceName: "resturantemenu")
        } else {
            self.image = #imageLiteral(resourceName: "food_service_logo-2")
        }
        
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
