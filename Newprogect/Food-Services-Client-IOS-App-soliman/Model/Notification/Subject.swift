//
//    Subject.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

//    The "Swift - Struct - Gloss" support has been made available by CodeEagle
//    More about him/her can be found at his/her website: https://github.com/CodeEagle

import Foundation
import Gloss

//MARK: - Subject
public struct Subject: Glossy {
    
    public let client : Int!
    public let clientDeliveryType : String!
    public let cooker : Int!
    public let cookerDeliveryType : String!
    public let creationDate : String!
    public let deliveryDate : Int!
    public let id : Int!
    public let kind : String!
    public let productOrders : [NotificationProductOrder]!
    public let rated : Bool!
    public let status : String!
    public let totalPrice : Float!
    public let price: Float!
    public let km: Int!
    public let order: Int!
    public let fromLocation: [Double]!
    public let toLocation: [Double]!
    public let deliveryGuy: Int!
    
    //MARK: Decodable
    public init?(json: JSON){
        client = "client" <~~ json
        clientDeliveryType = "clientDeliveryType" <~~ json
        cooker = "cooker" <~~ json
        cookerDeliveryType = "cookerDeliveryType" <~~ json
        creationDate = "creationDate" <~~ json
        deliveryDate = "deliveryDate" <~~ json
        id = "id" <~~ json
        kind = "kind" <~~ json
        productOrders = "productOrders" <~~ json
        rated = "rated" <~~ json
        status = "status" <~~ json
        totalPrice = "totalPrice" <~~ json
        price = "price" <~~ json
        km = "km" <~~ json
        order = "order" <~~ json
        fromLocation = "fromLocation" <~~ json
        toLocation = "toLocation" <~~ json
        deliveryGuy = "deliveryGuy" <~~ json
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
            "id" ~~> id,
            "kind" ~~> kind,
            "productOrders" ~~> productOrders,
            "rated" ~~> rated,
            "status" ~~> status,
            "totalPrice" ~~> totalPrice,
            "price"  ~~> price,
            "km"  ~~> km,
            "order"  ~~> order,
            "fromLocation"  ~~> fromLocation,
            "toLocation"  ~~> toLocation,
            "deliveryGuy"  ~~> deliveryGuy,
            ])
    }
    
}

