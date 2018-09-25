//
//	Data.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

//	The "Swift - Struct - Gloss" support has been made available by CodeEagle
//	More about him/her can be found at his/her website: https://github.com/CodeEagle

import Foundation 
import Gloss

//MARK: - Data
public struct FoodcarcatogaryData: Glossy {

	public let id : String!
	public let location : FoodcarLocation!
	public let name : AnyObject!
	public let phone : AnyObject!
	public let rating : AnyObject!



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
