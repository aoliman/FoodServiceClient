//
//  NotificationData.swift
//  FoodServiceProvider
//
//  Created by Index on 3/28/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import Foundation
import Gloss

//MARK: - Data
public struct NotificationData: Glossy {
    
    public let creationDate : String!
    public let fromUser : FromUser!
    public let id : Int!
    public let seen : Bool!
    public let subject : Subject!
    public let subjectType : String!
    public let text : String!
    
    
    
    //MARK: Decodable
    public init?(json: JSON){
        creationDate = "creationDate" <~~ json
        fromUser = "fromUser" <~~ json
        id = "id" <~~ json
        seen = "seen" <~~ json
        subject = "subject" <~~ json
        subjectType = "subjectType" <~~ json
        text = "text" <~~ json
    }
    
    
    //MARK: Encodable
    public func toJSON() -> JSON? {
        return jsonify([
            "creationDate" ~~> creationDate,
            "fromUser" ~~> fromUser,
            "id" ~~> id,
            "seen" ~~> seen,
            "subject" ~~> subject,
            "subjectType" ~~> subjectType,
            "text" ~~> text,
            ])
    }
    
}

