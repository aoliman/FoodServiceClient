//
//    RootClass.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

//    The "Swift - Struct - Gloss" support has been made available by CodeEagle
//    More about him/her can be found at his/her website: https://github.com/CodeEagle

import Foundation
import Gloss

//MARK: - RootClass
public struct ProfileResponseApi: Glossy {
    
    public let code : Int!
    public let success : Bool!
    public let user : ProfileUser!
    
    
    
    //MARK: Decodable
    public init?(json: JSON){
        code = "code" <~~ json
        success = "success" <~~ json
        user = "user" <~~ json
    }
    
    
    //MARK: Encodable
    public func toJSON() -> JSON? {
        return jsonify([
            "code" ~~> code,
            "success" ~~> success,
            "user" ~~> user,
            ])
    }
    
}
