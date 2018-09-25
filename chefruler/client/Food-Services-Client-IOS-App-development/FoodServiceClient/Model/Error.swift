//
//    Error.swift
//
//    Create by Ramy Code95 on 9/3/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

//    The "Swift - Struct - Gloss" support has been made available by CodeEagle
//    More about him/her can be found at his/her website: https://github.com/CodeEagle

import Foundation
import Gloss

//MARK: - Error
public struct Error: Glossy {
    
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
