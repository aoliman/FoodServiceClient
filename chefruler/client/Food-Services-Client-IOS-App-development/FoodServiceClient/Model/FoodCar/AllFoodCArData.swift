//
//	Data.swift
//
//	Create by index-ios on 14/4/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

//	The "Swift - Struct - Gloss" support has been made available by CodeEagle
//	More about him/her can be found at his/her website: https://github.com/CodeEagle

import Foundation 
import Gloss

//MARK: - Data
public struct AllFoodCArData: Glossy {

	public let id : Int!
	public let location : Location!
	public let name : String!
	public let profileImg : String!



	//MARK: Decodable
	public init?(json: JSON){
		id = "id" <~~ json
		location = "location" <~~ json
		name = "name" <~~ json
		profileImg = "profileImg" <~~ json
	}


	//MARK: Encodable
	public func toJSON() -> JSON? {
		return jsonify([
		"id" ~~> id,
		"location" ~~> location,
		"name" ~~> name,
		"profileImg" ~~> profileImg,
		])
	}

}
