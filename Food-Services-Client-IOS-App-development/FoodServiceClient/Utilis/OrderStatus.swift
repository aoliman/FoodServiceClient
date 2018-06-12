//
//  OrderStatus.swift
//  FoodServiceProvider
//
//  Created by Index on 2/20/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import Foundation

enum OrderStatus: String
{
    case allProduts = "All Order"
    case pending = "PENDING"
    case accepted = "ACCEPTED"
    case finished = "FINISHED"
    case delivered = "DELIVERED"
    case refused = "REFUSED"
    case arrived = "ARRIVED"
    case ontheWay = "ONTHEWAY"
    
    static let allValues : [OrderStatus] = [allProduts,pending, accepted, finished, delivered, refused,arrived,ontheWay]
    
    static func getOrderStatus() -> [String]
    {
        var allStatus = [String]()
        
        for item in OrderStatus.allValues
        {
            allStatus.append(item.rawValue)
        }
        return allStatus
    }
}

