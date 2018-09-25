//
//  ProductOrder.swift
//  FoodServiceProvider
//
//  Created by Index on 2/20/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import Foundation
import Gloss

//MARK: - ProductOrder
public struct ProductOrder: Glossy {
    
    public let count : Int!
    public let product : Product!
    
    
    
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
