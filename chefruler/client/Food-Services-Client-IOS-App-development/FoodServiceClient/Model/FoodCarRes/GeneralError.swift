//
//  GeneralError.swift
//  FoodServiceProvider
//
//  Created by Index on 2/13/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import Foundation
import Gloss

public struct APIError: Glossy {
    
    public let generalError : [GeneralError]?
    public let error: String?


    //MARK: Decodable
    public init?(json: JSON){
        generalError = "error" <~~ json
        error = "error" <~~ json

    }


    //MARK: Encodable
    public func toJSON() -> JSON? {
        
        return jsonify([
            "error" ~~> generalError,
            "error" ~~> error,
            ])
    }

}

//MARK: - Error
public struct GeneralError: Glossy {
    
    public let location : String!
    public let msg : String!
    public let param : String!
    public let value : String!
    
    
    
    //MARK: Decodable
    public init?(json: JSON){
        location = "location" <~~ json
        msg = "msg" <~~ json
        param = "param" <~~ json
        value = "value" <~~ json
    }
    
    
    //MARK: Encodable
    public func toJSON() -> JSON? {
        return jsonify([
            "location" ~~> location,
            "msg" ~~> msg,
            "param" ~~> param,
            "value" ~~> value,
            ])
    }
    
}
