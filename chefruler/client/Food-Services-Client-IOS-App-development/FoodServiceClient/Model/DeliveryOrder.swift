//
//	RootClass.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

//	The "Swift - Struct - Gloss" support has been made available by CodeEagle
//	More about him/her can be found at his/her website: https://github.com/CodeEagle

import Foundation 
import Gloss

//MARK: - RootClass
public struct DeliveryOrder: Glossy {

    public let client : Int!
    public let creationDate : String!
    public let deliveryGuy : Int!
    public let fromLocation : [Float]!
    public let id : Int!
    public let kind : String!
    public let km : Float!
    public let order : Int!
    public let price : Float!
    public let status : String!
    public let toLocation : [Float]!
    
    
    
    //MARK: Decodable
    public init?(json: JSON){
        client = "client" <~~ json
        creationDate = "creationDate" <~~ json
        deliveryGuy = "deliveryGuy" <~~ json
        fromLocation = "fromLocation" <~~ json
        id = "id" <~~ json
        kind = "kind" <~~ json
        km = "km" <~~ json
        order = "order" <~~ json
        price = "price" <~~ json
        status = "status" <~~ json
        toLocation = "toLocation" <~~ json
    }
    
    
    //MARK: Encodable
    public func toJSON() -> JSON? {
        return jsonify([
            "client" ~~> client,
            "creationDate" ~~> creationDate,
            "deliveryGuy" ~~> deliveryGuy,
            "fromLocation" ~~> fromLocation,
            "id" ~~> id,
            "kind" ~~> kind,
            "km" ~~> km,
            "order" ~~> order,
            "price" ~~> price,
            "status" ~~> status,
            "toLocation" ~~> toLocation,
            ])
    }
    
}
