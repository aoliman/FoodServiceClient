//
//  ErrorResponse.swift
//  FoodServiceClient
//
//  Created by Ramy Nasser Code95 on 3/9/18.
//  Copyright © 2018 Index. All rights reserved.
//

import Foundation
//
//    RootClass.swift
//
//    Create by Ramy Code95 on 9/3/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

//    The "Swift - Struct - Gloss" support has been made available by CodeEagle
//    More about him/her can be found at his/her website: https://github.com/CodeEagle

import Foundation
import Gloss

//MARK: - RootClass
public struct ErrorResponse: Glossy {
    
    public let error : [Error]!
    
    
    
    //MARK: Decodable
    public init?(json: JSON){
        error = "error" <~~ json
    }
    
    
    //MARK: Encodable
    public func toJSON() -> JSON? {
        return jsonify([
            "error" ~~> error,
            ])
    }
    
}
