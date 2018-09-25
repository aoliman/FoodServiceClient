//
//  CookerOrderAPI.swift
//  FoodServiceProvider
//
//  Created by Index on 2/20/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import Foundation
import Gloss

//MARK: - RootClass
public struct OrderResponseApi: Glossy {
    
    public var data : [OrderData]!
    public let limit : Int!
    public let links : Link!
    public let page : Int!
    public let pageCount : Int!
    public let totalCount : Int!
    
    
    
    //MARK: Decodable
    public init?(json: JSON){
        data = "data" <~~ json
        limit = "limit" <~~ json
        links = "links" <~~ json
        page = "page" <~~ json
        pageCount = "pageCount" <~~ json
        totalCount = "totalCount" <~~ json
    }
    
    
    //MARK: Encodable
    public func toJSON() -> JSON? {
        return jsonify([
            "data" ~~> data,
            "limit" ~~> limit,
            "links" ~~> links,
            "page" ~~> page,
            "pageCount" ~~> pageCount,
            "totalCount" ~~> totalCount,
            ])
    }
    
}

