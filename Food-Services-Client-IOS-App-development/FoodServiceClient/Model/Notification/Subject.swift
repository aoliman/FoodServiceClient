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
    public let productOrders : [ProductOrder]!
    public let status : String!
    public let totalPrice : Int!
    
    
    
    //MARK: Decodable
    public init?(json: JSON){
        client = "client" <~~ json
        clientDeliveryType = "clientDeliveryType" <~~ json
        cooker = "cooker" <~~ json
        cookerDeliveryType = "cookerDeliveryType" <~~ json
        creationDate = "creationDate" <~~ json
        deliveryDate = "deliveryDate" <~~ json
        id = "id" <~~ json
        productOrders = "productOrders" <~~ json
        status = "status" <~~ json
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
            "id" ~~> id,
            "productOrders" ~~> productOrders,
            "status" ~~> status,
            "totalPrice" ~~> totalPrice,
            ])
    }
    
}
