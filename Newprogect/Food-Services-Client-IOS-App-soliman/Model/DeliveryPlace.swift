//
//    DeliveryPlace.swift
//
//    Create by Index PC-2 on 25/3/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

//    The "Swift - Struct - Gloss" support has been made available by CodeEagle
//    More about him/her can be found at his/her website: https://github.com/CodeEagle

import Foundation
import Gloss

//MARK: - DeliveryPlace
public struct DeliveryPlace: Glossy {
    
    public let accepted : Bool!
    public let address : String!
    public let email : String!
    public let fieldEmpty : Int!
    public let id : Int!
    public let location : Location!
    public let name : String!
    public let online : Bool!
    public let phone : String!
    public let placeImgs : [String]!
    public let placeLicenseImgs : [String]!
    public let profileImg : String!
    public let providedServices : [String]!
    public let rating : Int!
    public let type : String!
    public let userCardImgs : [String]!
    public let HomecokerLocation : Location!
    
    
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
        placeImgs = "placeImgs" <~~ json
        placeLicenseImgs = "placeLicenseImgs" <~~ json
        profileImg = "profileImg" <~~ json
        providedServices = "providedServices" <~~ json
        rating = "rating" <~~ json
        type = "type" <~~ json
        userCardImgs = "userCardImgs" <~~ json
        HomecokerLocation = "location" <~~ json
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
            "placeImgs" ~~> placeImgs,
            "placeLicenseImgs" ~~> placeLicenseImgs,
            "profileImg" ~~> profileImg,
            "providedServices" ~~> providedServices,
            "rating" ~~> rating,
            "type" ~~> type,
            "userCardImgs" ~~> userCardImgs,
            "location" ~~> HomecokerLocation,
            ])
    }
    
}
