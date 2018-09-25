//
//    RootClass.swift
//
//    Create by Ramy Code95 on 8/3/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

//    The "Swift - Struct - Gloss" support has been made available by CodeEagle
//    More about him/her can be found at his/her website: https://github.com/CodeEagle

import Foundation
import Gloss

//MARK: - RootClass
public struct LoginResponseApi: Glossy {
    
    public let token : String!
    public let user : User!
    
    
    
    //MARK: Decodable
    public init?(json: JSON){
        token = "token" <~~ json
        user = "user" <~~ json
    }
    
    
    //MARK: Encodable
    public func toJSON() -> JSON? {
        return jsonify([
            "token" ~~> token,
            "user" ~~> user,
            ])
    }
    
}
