//
//  OrderInfoCellData.swift
//  FoodService
//
//  Created by index-ios on 3/14/18.
//  Copyright © 2018 index-ios. All rights reserved.
//

import Foundation
class OrderInfoCellData{
    var Price:String
    var Name:String
    var Quantity:String
    init(Price:String, Name:String, quantity:String) {
        self.Name=Name
        self.Price=Price
        self.Quantity=quantity
    }
    
}
