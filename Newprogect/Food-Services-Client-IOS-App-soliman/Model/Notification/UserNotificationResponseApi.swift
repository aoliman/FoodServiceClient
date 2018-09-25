//
//    RootClass.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

//    The "Swift - Struct - Gloss" support has been made available by CodeEagle
//    More about him/her can be found at his/her website: https://github.com/CodeEagle

import Foundation
import Gloss

//MARK: - RootClass
public struct UserNotificationResponseApi: Glossy {
    
    public let code : Int!
    public var data : [NotificationData]!
    public let limit : Int!
    public let links : Link!
    public let message : String!
    public let page : Int!
    public let pageCount : Int!
    public let success : Bool!
    public let totalCount : Int!
    
    
    
    //MARK: Decodable
    public init?(json: JSON){
        code = "code" <~~ json
        data = "data" <~~ json
        limit = "limit" <~~ json
        links = "links" <~~ json
        message = "message" <~~ json
        page = "page" <~~ json
        pageCount = "pageCount" <~~ json
        success = "success" <~~ json
        totalCount = "totalCount" <~~ json
    }
    
    
    //MARK: Encodable
    public func toJSON() -> JSON? {
        return jsonify([
            "code" ~~> code,
            "data" ~~> data,
            "limit" ~~> limit,
            "links" ~~> links,
            "message" ~~> message,
            "page" ~~> page,
            "pageCount" ~~> pageCount,
            "success" ~~> success,
            "totalCount" ~~> totalCount,
            ])
    }
    
}
