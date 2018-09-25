//
//    Data.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

//    The "Swift - Struct - Gloss" support has been made available by CodeEagle
//    More about him/her can be found at his/her website: https://github.com/CodeEagle

import Foundation
import Gloss

//MARK: - Data
public struct UserNotification: Glossy {
    
    public let id : Int!
    public let notificationContent : String!
    public let notificationTime : Int!
    
    
    
    //MARK: Decodable
    public init?(json: JSON){
        id = "id" <~~ json
        notificationContent = "notification_content" <~~ json
        notificationTime = "notification_time" <~~ json
    }
    
    
    //MARK: Encodable
    public func toJSON() -> JSON? {
        return jsonify([
            "id" ~~> id,
            "notification_content" ~~> notificationContent,
            "notification_time" ~~> notificationTime,
            ])
    }
    
}
