//
//    Product.swift
//
//    Create by Index PC-2 on 8/4/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

//    The "Swift - Struct - Gloss" support has been made available by CodeEagle
//    More about him/her can be found at his/her website: https://github.com/CodeEagle

import Foundation
import Gloss

//MARK: - Product
public struct Product: Glossy {
    
    public let category : Int!
    public let cookingDuration : Int!
    public let cookingDurationTimeUnit : String!
    public let creationDate : String!
    public let id : Int!
    public let imgs : [String]!
    public let ingredients : String!
    public let kind : String!
    public let lock : Bool!
    public let maxAmountToOrder : Int!
    public let maxOrdersInDay : Int!
    public let minAmountToOrder : Int!
    public let minPeriodToOrder : String!
    public let name : String!
    public let owner : Int!
    public let price : Int!
    public let rating : Int!
    public let serviceFees : Int?
    
    
    //MARK: Decodable
    public init?(json: JSON){
        category = "category" <~~ json
        cookingDuration = "cookingDuration" <~~ json
        cookingDurationTimeUnit = "cookingDurationTimeUnit" <~~ json
        creationDate = "creationDate" <~~ json
        id = "id" <~~ json
        imgs = "imgs" <~~ json
        ingredients = "ingredients" <~~ json
        kind = "kind" <~~ json
        lock = "lock" <~~ json
        maxAmountToOrder = "maxAmountToOrder" <~~ json
        maxOrdersInDay = "maxOrdersInDay" <~~ json
        minAmountToOrder = "minAmountToOrder" <~~ json
        minPeriodToOrder = "minPeriodToOrder" <~~ json
        name = "name" <~~ json
        owner = "owner" <~~ json
        price = "price" <~~ json
        rating = "rating" <~~ json
        serviceFees = "serviceFees" <~~ json
    }
    
    
    //MARK: Encodable
    public func toJSON() -> JSON? {
        return jsonify([
            "category" ~~> category,
            "cookingDuration" ~~> cookingDuration,
            "cookingDurationTimeUnit" ~~> cookingDurationTimeUnit,
            "creationDate" ~~> creationDate,
            "id" ~~> id,
            "imgs" ~~> imgs,
            "ingredients" ~~> ingredients,
            "kind" ~~> kind,
            "lock" ~~> lock,
            "maxAmountToOrder" ~~> maxAmountToOrder,
            "maxOrdersInDay" ~~> maxOrdersInDay,
            "minAmountToOrder" ~~> minAmountToOrder,
            "minPeriodToOrder" ~~> minPeriodToOrder,
            "name" ~~> name,
            "owner" ~~> owner,
            "price" ~~> price,
            "rating" ~~> rating,
            ])
    }
    
}
