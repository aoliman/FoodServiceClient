//
//	RootClass.swift
//
//	Create by index-ios on 8/5/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

//	The "Swift - Struct - Gloss" support has been made available by CodeEagle
//	More about him/her can be found at his/her website: https://github.com/CodeEagle

import Foundation 
import Gloss

//MARK: - RootClass
public struct FoodCarMapRes: Glossy {

	public let id : String!
	public let location : [String]!
	public let name : String!
	public let phone : String!
    public let status : String!
    public let rating : String!


	//MARK: Decodable
	public init?(json: JSON){
		id = "id" <~~ json
		location = "location" <~~ json
		name = "name" <~~ json
		phone = "phone" <~~ json
        status = "status" <~~ json
        rating = "rating" <~~ json

	}


	//MARK: Encodable
	public func toJSON() -> JSON? {
		return jsonify([
		"id" ~~> id,
		"location" ~~> location,
		"name" ~~> name,
		"phone" ~~> phone,
        "status" ~~> status,
        "rating" ~~> rating,
		])
	}

}
