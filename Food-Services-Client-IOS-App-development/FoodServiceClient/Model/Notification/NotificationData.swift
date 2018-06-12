//
//    Data.swift
//
//    Create by Index PC-2 on 25/3/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

//    The "Swift - Struct - Gloss" support has been made available by CodeEagle
//    More about him/her can be found at his/her website: https://github.com/CodeEagle

import Foundation
import Gloss

//MARK: - Data
public struct NotificationData: Glossy {
    
    public let client : Client!
    public let clientDeliveryType : String!
    public let cooker : Cooker!
    public let cookerDeliveryType : String!
    public let creationDate : String!
    public let deliveryDate : Int!
    public let deliveryGuy : DeliveryGuy!
    public let deliveryPlace : DeliveryPlace!
    public let fromLocation : [Float]!
    public let id : Int!
    public let kind : String!
    public let km : Int!
    public let order : Int!
    public let price : Int!
    public let productOrders : [ProductOrder]!
    public let status : String!
    public let toLocation : [Float]!
    public let totalPrice : Int!
    
    
    
    //MARK: Decodable
    public init?(json: JSON){
        client = "client" <~~ json
        clientDeliveryType = "clientDeliveryType" <~~ json
        cooker = "cooker" <~~ json
        cookerDeliveryType = "cookerDeliveryType" <~~ json
        creationDate = "creationDate" <~~ json
        deliveryDate = "deliveryDate" <~~ json
        deliveryGuy = "deliveryGuy" <~~ json
        deliveryPlace = "deliveryPlace" <~~ json
        fromLocation = "fromLocation" <~~ json
        id = "id" <~~ json
        kind = "kind" <~~ json
        km = "km" <~~ json
        order = "order" <~~ json
        price = "price" <~~ json
        productOrders = "productOrders" <~~ json
        status = "status" <~~ json
        toLocation = "toLocation" <~~ json
        totalPrice = "totalPrice" <~~ json
    }
    
    
    //MARK: Encodable
    public func toJSON() -> JSON? {
        return jsonify([
            "client" ~~> client,
            "clientDeliveryType" ~~> clientDeliveryType,
            "cooker" ~~> cooker,
            "cookerDeliveryType" ~~> cookerDeliveryType,
            "creationDate" ~~> creationDate,
            "deliveryDate" ~~> deliveryDate,
            "deliveryGuy" ~~> deliveryGuy,
            "deliveryPlace" ~~> deliveryPlace,
            "fromLocation" ~~> fromLocation,
            "id" ~~> id,
            "kind" ~~> kind,
            "km" ~~> km,
            "order" ~~> order,
            "price" ~~> price,
            "productOrders" ~~> productOrders,
            "status" ~~> status,
            "toLocation" ~~> toLocation,
            "totalPrice" ~~> totalPrice,
            ])
    }
    
}
