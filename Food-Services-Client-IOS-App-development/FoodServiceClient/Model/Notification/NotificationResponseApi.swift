//
//    RootClass.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

//    The "Swift - Struct - Gloss" support has been made available by CodeEagle
//    More about him/her can be found at his/her website: https://github.com/CodeEagle

import Foundation
import Gloss

//MARK: - RootClass
public struct NotificationResponseApi: Glossy {
    
    public let creationDate : String!
    public let fromUser : FromUser!
    public let id : Int!
    public let subject : Subject!
    public let subjectType : String!
    public let text : String!
    
    
    
    //MARK: Decodable
    public init?(json: JSON){
        creationDate = "creationDate" <~~ json
        fromUser = "fromUser" <~~ json
        id = "id" <~~ json
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
            "subject" ~~> subject,
            "subjectType" ~~> subjectType,
            "text" ~~> text,
            ])
    }
    
}
