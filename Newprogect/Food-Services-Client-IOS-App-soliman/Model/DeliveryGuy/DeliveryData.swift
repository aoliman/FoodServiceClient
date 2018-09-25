//
//	Data.swift
//
//	Create by Index on 7/6/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

//	The "Swift - Struct - Gloss" support has been made available by CodeEagle
//	More about him/her can be found at his/her website: https://github.com/CodeEagle

import Foundation 
import Gloss

//MARK: - Data
public struct DeliveryData: Glossy {

	public let id : String!
	public let  location: DeliveryLocation!
	public let name : String!
	public let phone : String!
	public let rating : String!



	//MARK: Decodable
	public init?(json: JSON){
		id = "id" <~~ json
		location = "location" <~~ json
		name = "name" <~~ json
		phone = "phone" <~~ json
		rating = "rating" <~~ json
	}


	//MARK: Encodable
	public func toJSON() -> JSON? {
		return jsonify([
		"id" ~~> id,
		"location" ~~> location,
		"name" ~~> name,
		"phone" ~~> phone,
		"rating" ~~> rating,
		])
	}

}
