//
//  LinkModel.swift
//  FoodServiceProvider
//
//  Created by Index on 1/7/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import Foundation
import Gloss

//MARK: - Link
public struct Link: Glossy {
    
    public let first : String?
    public let last : String?
    public let next : String?
    public let current : String!
    public let linkself : String!
    
    
    //MARK: Decodable
    public init?(json: JSON){
        first = "first" <~~ json
        last = "last" <~~ json
        next = "next" <~~ json
        current = "self" <~~ json
    linkself = "self" <~~ json
        
    }
    
    
    //MARK: Encodable
    public func toJSON() -> JSON? {
        return jsonify([
            "first" ~~> first,
            "last" ~~> last,
            "next" ~~> next,
            "self" ~~> current,
            "self" ~~> linkself,
            ])
    }
    
}
