//
//  ChatModel.swift
//  FoodServiceProvider
//
//  Created by Index on 1/7/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import Foundation
import Gloss

//MARK: - RootClass
public struct ChatModel: Glossy {
    
    public let code : Int!
    public var data : [DataModel]!
    public let limit : Int!
    public let links : Link!
    public let message : String!
    public let page : Int!
    public let pageCount : Int!
    public let success : Bool!
    public let totalCount : Int!
    
    
    
    //MARK: Decodable
    public init?(json: JSON){
        code = "code" <~~ json
        data = "data" <~~ json
        limit = "limit" <~~ json
        links = "links" <~~ json
        message = "message" <~~ json
        page = "page" <~~ json
        pageCount = "pageCount" <~~ json
        success = "success" <~~ json
        totalCount = "totalCount" <~~ json
    }
    
    
    //MARK: Encodable
    public func toJSON() -> JSON? {
        return jsonify([
            "code" ~~> code,
            "data" ~~> data,
            "limit" ~~> limit,
            "links" ~~> links,
            "message" ~~> message,
            "page" ~~> page,
            "pageCount" ~~> pageCount,
            "success" ~~> success,
            "totalCount" ~~> totalCount,
            ])
    }
    
}
