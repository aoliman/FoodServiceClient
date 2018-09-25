//
//    ProfileUser.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

//    The "Swift - Struct - Gloss" support has been made available by CodeEagle
//    More about him/her can be found at his/her website: https://github.com/CodeEagle

import Foundation
import Gloss

//MARK: - User
public struct ProfileUser: Glossy {
    
    public let deliveryHome : String!
    public let email : String!
    public let id : Int!
    public let lant : Float!
    public let lat : Float!
    public let name : String!
    public let online : Bool!
    public let phone : String!
    public let placeImage : String!
    public let placeServices : String!
    public let userAddress : String!
    public let userType : String!
    
    
    
    //MARK: Decodable
    public init?(json: JSON){
        deliveryHome = "delivery_home" <~~ json
        email = "email" <~~ json
        id = "id" <~~ json
        lant = "lant" <~~ json
        lat = "lat" <~~ json
        name = "name" <~~ json
        online = "online" <~~ json
        phone = "phone" <~~ json
        placeImage = "place_image" <~~ json
        placeServices = "place_services" <~~ json
        userAddress = "user_address" <~~ json
        userType = "user_type" <~~ json
    }
    
    
    //MARK: Encodable
    public func toJSON() -> JSON? {
        return jsonify([
            "delivery_home" ~~> deliveryHome,
            "email" ~~> email,
            "id" ~~> id,
            "lant" ~~> lant,
            "lat" ~~> lat,
            "name" ~~> name,
            "online" ~~> online,
            "phone" ~~> phone,
            "place_image" ~~> placeImage,
            "place_services" ~~> placeServices,
            "user_address" ~~> userAddress,
            "user_type" ~~> userType,
            ])
    }
    
}
