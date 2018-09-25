//
//  CategoryData.swift
//  FoodServiceProvider
//
//  Created by Index on 1/17/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import Foundation
import Gloss

//MARK: - Data
public struct CategoryData: Glossy {
   
    public let id : Int!
    public let img : String!
    public let name : String!
    
    
    
    //MARK: Decodable
    public init?(json: JSON){
        id = "id" <~~ json
        img = "img" <~~ json
        name = "name" <~~ json
    }
    
    
    //MARK: Encodable
    public func toJSON() -> JSON? {
        return jsonify([
            "id" ~~> id,
            "img" ~~> img,
            "name" ~~> name,
            ])
    }
    
}
