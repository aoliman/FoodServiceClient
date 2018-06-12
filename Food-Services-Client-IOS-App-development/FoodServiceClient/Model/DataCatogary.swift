//
//	Data.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

//	The "Swift - Struct - Gloss" support has been made available by CodeEagle
//	More about him/her can be found at his/her website: https://github.com/CodeEagle

import Foundation 
import Gloss

//MARK: - Data
public struct DataCatogary: Glossy {

	public let id : Int!
	public let location : Location!
	public let name : String!
	public let profileImg : String!
    public let rating : Double!


	//MARK: Decodable
	public init?(json: JSON){
		id = "id" <~~ json
		location = "location" <~~ json
		name = "name" <~~ json
		profileImg = "profileImg" <~~ json
        rating = "rating" <~~ json
	}


	//MARK: Encodable
	public func toJSON() -> JSON? {
		return jsonify([
		"id" ~~> id,
		"location" ~~> location,
		"name" ~~> name,
		"profileImg" ~~> profileImg,
        "rating" ~~> rating,
		])
	}

}
