//
//    ProductOrder.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

//    The "Swift - Struct - Gloss" support has been made available by CodeEagle
//    More about him/her can be found at his/her website: https://github.com/CodeEagle

import Foundation
import Gloss

//MARK: - ProductOrder
public struct NotificationProductOrder: Glossy {
    
    public let count : Int!
    public let product : Int!
    
    
    
    //MARK: Decodable
    public init?(json: JSON){
        count = "count" <~~ json
        product = "product" <~~ json
    }
    
    
    //MARK: Encodable
    public func toJSON() -> JSON? {
        return jsonify([
            "count" ~~> count,
            "product" ~~> product,
            ])
    }
    
}
