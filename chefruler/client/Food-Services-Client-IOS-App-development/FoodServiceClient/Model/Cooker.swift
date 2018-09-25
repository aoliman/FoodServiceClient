//
//    Cooker.swift
//
//    Create by Index PC-2 on 1/4/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

//    The "Swift - Struct - Gloss" support has been made available by CodeEagle
//    More about him/her can be found at his/her website: https://github.com/CodeEagle

import Foundation
import Gloss

//MARK: - Cooker
public struct Cooker: Glossy {
    
    public let accepted : Bool!
    public let address : String!
    public let commercialRegisterImgs : [String]!
    public let email : String!
    public let fieldEmpty : Int!
    public let hasDeliveryPlaces : Bool!
    public let healthAnalysisImgs : [String]!
    public let id : Int!
    public let location : Location!
    public let name : String!
    public let online : Bool!
    public let phone : String!
    public let placeImgs : [String]!
    public let profileImg : String!
    public let rating : Int!
    public let type : String!
    public let userCardImgs : [String]!
    public let workerCardImgs : [String]!
    public let workerHealthAnalysisImgs : [String]!
    
    
    
    //MARK: Decodable
    public init?(json: JSON){
        accepted = "accepted" <~~ json
        address = "address" <~~ json
        commercialRegisterImgs = "commercialRegisterImgs" <~~ json
        email = "email" <~~ json
        fieldEmpty = "field_empty" <~~ json
        hasDeliveryPlaces = "hasDeliveryPlaces" <~~ json
        healthAnalysisImgs = "healthAnalysisImgs" <~~ json
        id = "id" <~~ json
        location = "location" <~~ json
        name = "name" <~~ json
        online = "online" <~~ json
        phone = "phone" <~~ json
        placeImgs = "placeImgs" <~~ json
        profileImg = "profileImg" <~~ json
        rating = "rating" <~~ json
        type = "type" <~~ json
        userCardImgs = "userCardImgs" <~~ json
        workerCardImgs = "workerCardImgs" <~~ json
        workerHealthAnalysisImgs = "workerHealthAnalysisImgs" <~~ json
    }
    
    
    //MARK: Encodable
    public func toJSON() -> JSON? {
        return jsonify([
            "accepted" ~~> accepted,
            "address" ~~> address,
            "commercialRegisterImgs" ~~> commercialRegisterImgs,
            "email" ~~> email,
            "field_empty" ~~> fieldEmpty,
            "hasDeliveryPlaces" ~~> hasDeliveryPlaces,
            "healthAnalysisImgs" ~~> healthAnalysisImgs,
            "id" ~~> id,
            "location" ~~> location,
            "name" ~~> name,
            "online" ~~> online,
            "phone" ~~> phone,
            "placeImgs" ~~> placeImgs,
            "profileImg" ~~> profileImg,
            "rating" ~~> rating,
            "type" ~~> type,
            "userCardImgs" ~~> userCardImgs,
            "workerCardImgs" ~~> workerCardImgs,
            "workerHealthAnalysisImgs" ~~> workerHealthAnalysisImgs,
            ])
    }
    
}
