//
//  defaultsKey.swift
//  FoodServiceProvider
//
//  Created by Index on 12/21/17.
//  Copyright © 2017 index-pc. All rights reserved.
//

import Foundation
enum defaultsKey: String {
    case token = "token"
    case userId = "userId"
    case userData = "userData"
    case name = "name"
    case isLogged = "logged"
    case onlineStatus = "onlineStatus"
    //case userType = "UserType"
    case productId = "productId"
    case categoryName = "categoryName"
    case categoryId = "categoryId"
    case sr = "Sr"
    case deliverPlaceDetails = "deliverPlaceDetails"
   // case client = "CLIENT"
    case fcmToken = "notificationToken"
    case language = "language"
    case userType = "CLIENT"

    case userName = "userName"
    case userEmail = "userEmail"
    case userPhone = "userPhone"
    case userPassword = "userPassword"


    
}

enum productTime: String {
    case day = "MIN"
    case hour = "HOUR"
    case minute = "DAY"
}

enum month: Int {
     case January      = 1
     case February     = 2
     case March        = 3
     case April        = 4
     case May          = 5
     case June         = 6
     case July         = 7
     case August       = 8
     case September    = 9
     case October      = 10
     case November     = 11
     case December     = 12

}

enum deliveryPlaceStatus: String {
    case AllProduct = "AllProduct"
    case ACCEPTED = "ACCEPTED"
    case PENDING = "PENDING"
    case REFUSED = "REFUSED"
}

