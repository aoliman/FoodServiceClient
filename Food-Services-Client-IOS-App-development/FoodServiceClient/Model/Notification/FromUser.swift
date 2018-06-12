//
//    FromUser.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

//    The "Swift - Struct - Gloss" support has been made available by CodeEagle
//    More about him/her can be found at his/her website: https://github.com/CodeEagle

import Foundation
import Gloss

//MARK: - FromUser
public struct FromUser: Glossy {
    
    public let accepted : Bool!
    public let address : String!
    public let email : String!
    public let fieldEmpty : Int!
    public let id : Int!
    public let location : Location!
    public let name : String!
    public let online : Bool!
    public let phone : String!
    public let profileImg : String!
    public let type : String!
    
    
    
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
            "type" ~~> type,
            ])
    }
    
}
