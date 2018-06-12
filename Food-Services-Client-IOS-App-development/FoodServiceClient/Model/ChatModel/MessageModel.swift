//
//  LastMessageModel.swift
//  FoodServiceProvider
//
//  Created by Index on 1/8/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import Foundation
import Gloss

public struct MessageModel: Glossy {
    
    public let key : String!
    public let message : String!
    public let messageStatus : Int!
    public let sender : String!
    public let data: Int?
    
    
    //MARK: Decodable
    public init?(json: JSON){
        key = "key" <~~ json
        message = "message" <~~ json
        messageStatus = "messageStatus" <~~ json
        sender = "sender" <~~ json
        data = "data" <~~ json
    }
    
    
    //MARK: Encodable
    public func toJSON() -> JSON? {
        return jsonify([
            "key" ~~> key,
            "message" ~~> message,
            "messageStatus" ~~> messageStatus,
            "sender" ~~> sender,
            "data" ~~> data,
            ])
    }
    
}
