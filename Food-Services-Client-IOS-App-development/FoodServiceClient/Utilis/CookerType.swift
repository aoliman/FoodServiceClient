//
//  URLRouting.swift
//  FoodServiceProvider
//
//  Created by Index on 2/12/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import Foundation
class CookerType
{
    static func checkType(userType:String) -> String
    {
       
        
        if userType.contains("PARTY_COOKER") {
            return "party-cookers"
        } else if userType.contains("HOME_COOKER") {
            return "home-cookers"
        }else if userType.contains("food-FOOD_CAR")  {
            return "food-cars"
        } else if userType.contains("DELIVERY_PLACE") {
            return "delivery-guys"
        } else  if userType.contains("DELIVERY_PLACE") {
            return "delivery-places"
        } else {
            return "home-cookers"

        }
//        switch userType
//        {
//        case UserType.houseCook.rawValue:
//            return "home-cookers"
//
//        case UserType.partyCooks.rawValue:
//            return  "party-cookers"
//
//        case UserType.driverPartner.rawValue:
//            return  "delivery-guys"
//        case UserType.deliveryPlace.rawValue:
//            return  "delivery-places"
//        case UserType.foodCars.rawValue:
//            return  ""
//        default:
//            return  ""
//        }
    }
}
enum UserType: String
{
    case deliveryPlace = "DELIVERY_PLACE"
    case foodCars = "FOOD_CAR"
    case houseCook = "HOME_COOKER"
    case partyCooks = "PARTY_COOKER"
    case driverPartner = "DELIVERY_GUY"
}


