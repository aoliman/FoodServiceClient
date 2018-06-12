//
//    User.swift
//
//    Create by Ramy Code95 on 8/3/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

//    The "Swift - Struct - Gloss" support has been made available by CodeEagle
//    More about him/her can be found at his/her website: https://github.com/CodeEagle

import Foundation
import Gloss

//MARK: - User
public struct User: Glossy {
    
    public var accepted : Bool!
    public var address : String!
    public var email : String!
    public var fieldEmpty : Int!
    public var id : Int!
    public var location : Location!
    public var name : String!
    public var online : Bool!
    public var phone : String!
    public var profileImg : String!
    public var profileImgs : [String]!
    public var type : String!
    
    
    //MARK: Decodable
    public init?(json: JSON){
        accepted = "accepted" <~~ json
        address = "address" <~~ json
        email = "email" <~~ json
        fieldEmpty = "field_empty" <~~ json
        id = "id" <~~ json
        location = "location" <~~ json
        name = "name" <~~ json
        online = "online" <~~ json
        phone = "phone" <~~ json
        profileImg = "profileImg" <~~ json
        profileImgs = "profileImgs" <~~ json
        type = "type" <~~ json
    }
    
    
    //MARK: Encodable
    public func toJSON() -> JSON? {
        return jsonify([
            "accepted" ~~> accepted,
            "address" ~~> address,
            "email" ~~> email,
            "field_empty" ~~> fieldEmpty,
            "id" ~~> id,
            "location" ~~> location,
            "name" ~~> name,
            "online" ~~> online,
            "phone" ~~> phone,
            "profileImg" ~~> profileImg,
            "profileImgs" ~~> profileImgs,
            "type" ~~> type,
            ])
    }
    
}
