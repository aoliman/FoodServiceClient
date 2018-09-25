//
//  RegisterApi.swift
//  FoodServiceProvider
//
//  Created by Index on 1/29/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import Foundation
import Gloss

//MARK: - RootClass
public struct RegisterApi: Glossy {
            
  
    public let token : String?
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
