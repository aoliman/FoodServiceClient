//
//  Location.swift
//  FoodServiceClient
//
//  Created by Ramy Nasser Code95 on 3/8/18.
//  Copyright © 2018 Index. All rights reserved.
//


import Foundation
import Gloss

//MARK: - Location
public struct Location: Glossy {
    
    public let lat : Float!
    public let lng : Float!
    
    
    
    //MARK: Decodable
    public init?(json: JSON){
        lat = "lat" <~~ json
        lng = "lng" <~~ json
    }
    
    
    //MARK: Encodable
    public func toJSON() -> JSON? {
        return jsonify([
            "lat" ~~> lat,
            "lng" ~~> lng,
            ])
    }
    
}
