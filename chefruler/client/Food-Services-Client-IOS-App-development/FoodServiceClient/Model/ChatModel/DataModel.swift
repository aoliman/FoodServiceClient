//
//  DataModel.swift
//  FoodServiceProvider
//
//  Created by Index on 1/7/18.
//  Copyright © 2018 index-pc. All rights reserved.
//
import Foundation
import Gloss

//MARK: - Data
public struct DataModel: Glossy {
    
    public let id : Int!
    public let name : String!
    public let online : String!
    public let placeImage : String!
    
    
    
    //MARK: Decodable
    public init?(json: JSON){
        id = "id" <~~ json
        name = "name" <~~ json
        online = "online" <~~ json
        placeImage = "place_image" <~~ json
    }
    
    
    //MARK: Encodable
    public func toJSON() -> JSON? {
        return jsonify([
            "id" ~~> id,
            "name" ~~> name,
            "online" ~~> online,
            "place_image" ~~> placeImage,
            ])
    }
    
}
